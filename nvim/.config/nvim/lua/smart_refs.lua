local M = {}

----------------------------------------------------------------
-- Helpers to get the symbol at the cursor using document symbols
----------------------------------------------------------------

-- Recursively flatten document symbols
local function flatten_symbols(symbols, out)
	out = out or {}
	for _, sym in ipairs(symbols) do
		table.insert(out, sym)
		if sym.children then
			flatten_symbols(sym.children, out)
		end
	end
	return out
end

-- Check if a given position is inside a given range.
local function in_range(pos, range)
	local start = range.start
	local finish = range["end"]
	if pos.line < start.line or pos.line > finish.line then
		return false
	end
	if pos.line == start.line and pos.character < start.character then
		return false
	end
	if pos.line == finish.line and pos.character > finish.character then
		return false
	end
	return true
end

-- Synchronously request document symbols, flatten them,
-- and then return the smallest symbol (by range) that encloses the cursor.
local function get_symbol_at_cursor()
	local current_uri = vim.uri_from_bufnr(0)
	local params = vim.lsp.util.make_position_params()
	local response =
		vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", { textDocument = { uri = current_uri } }, 1000)
	if not response then
		return nil
	end

	local symbols = {}
	for _, res in pairs(response) do
		if res.result then
			if vim.tbl_islist(res.result) then
				for _, sym in ipairs(res.result) do
					table.insert(symbols, sym)
				end
			else
				-- Sometimes the result is a single tree
				table.insert(symbols, res.result)
			end
		end
	end

	if vim.tbl_isempty(symbols) then
		return nil
	end

	local flat_symbols = flatten_symbols(symbols)
	local best = nil
	for _, sym in ipairs(flat_symbols) do
		local range = sym.range or (sym.location and sym.location.range)
		if range and in_range(params.position, range) then
			if not best then
				best = sym
			else
				local best_range = best.range or (best.location and best.location.range)
				local best_size = (best_range["end"].line - best_range.start.line) * 1000
					+ (best_range["end"].character - best_range.start.character)
				local curr_size = (range["end"].line - range.start.line) * 1000
					+ (range["end"].character - range.start.character)
				if curr_size < best_size then
					best = sym
				end
			end
		end
	end

	return best
end

----------------------------------------------------------------
-- Helper: Telescope picker for references (with fallback)
----------------------------------------------------------------
local function telescope_picker_for_references(references, prompt_title)
	local has_telescope, pickers = pcall(require, "telescope.pickers")
	if not has_telescope then
		-- Fallback to the quickfix list if Telescope isn’t available.
		local items = vim.lsp.util.locations_to_items(references)
		vim.fn.setqflist({}, " ", { title = prompt_title, items = items })
		vim.cmd("copen")
		return
	end
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	pickers
		.new({}, {
			prompt_title = prompt_title,
			finder = finders.new_table({
				results = references,
				entry_maker = function(entry)
					local uri = entry.uri or entry.targetUri
					local range = entry.range or entry.targetSelectionRange
					local filename = vim.uri_to_fname(uri)
					local line = range.start.line + 1
					return {
						value = entry,
						display = string.format("%s:%d", filename, line),
						ordinal = string.format("%s:%d", filename, line),
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						vim.lsp.util.jump_to_location(selection.value, "utf-8")
					end
				end)
				return true
			end,
		})
		:find()
end

----------------------------------------------------------------
-- The main "smart references" command.
----------------------------------------------------------------
M.smart_references = function()
	local params = vim.lsp.util.make_position_params()
	local current_uri = vim.uri_from_bufnr(0)
	local current_pos = params.position

	-- Check the symbol at the cursor.
	local symbol = get_symbol_at_cursor()
	-- Only trigger the special behavior if the symbol is a function (kind 12)
	-- or a method (kind 6). For other symbols (e.g. variables), just use the normal lookup.
	if not symbol or not (symbol.kind == 12 or symbol.kind == 6) then
		require("telescope.builtin").lsp_references()
		return
	end

	-- Use "go to definition" to see if there is an abstract (parent) symbol.
	vim.lsp.buf_request(0, "textDocument/definition", params, function(err, def_results, _)
		if err then
			vim.notify("Error retrieving definition: " .. err.message, vim.log.levels.ERROR)
			require("telescope.builtin").lsp_references()
			return
		end

		local def_candidate = nil
		if def_results and #def_results > 0 then
			for _, loc in ipairs(def_results) do
				if loc.uri or loc.targetUri then
					local range = loc.range or loc.targetSelectionRange
					-- If the definition location is different from the current position,
					-- assume it is the abstract (parent) symbol.
					if
						range
						and (
							loc.uri ~= current_uri
							or range.start.line ~= current_pos.line
							or range.start.character ~= current_pos.character
						)
					then
						def_candidate = loc
						break
					end
				end
			end
		end

		if def_candidate then
			-- Prompt the user to choose which references they want.
			vim.ui.select(
				{ "Concrete (current symbol)", "Abstract (parent symbol)" },
				{ prompt = "Find references for:" },
				function(choice, idx)
					if not choice then
						return
					end
					if idx == 1 then
						-- For the concrete symbol, delegate to Telescope’s built‑in lsp_references.
						require("telescope.builtin").lsp_references()
					elseif idx == 2 then
						-- For the abstract symbol, build new parameters using the definition location.
						local target_uri = def_candidate.uri or def_candidate.targetUri
						local target_range = def_candidate.range or def_candidate.targetSelectionRange
						local new_params = {
							textDocument = { uri = target_uri },
							position = target_range.start,
							context = { includeDeclaration = false },
						}
						vim.lsp.buf_request(0, "textDocument/references", new_params, function(ref_err, references, _)
							if ref_err then
								vim.notify("Error retrieving references: " .. ref_err.message, vim.log.levels.ERROR)
								return
							end
							if references and #references > 0 then
								telescope_picker_for_references(references, "References (Abstract)")
							else
								vim.notify("No references found for the abstract symbol.", vim.log.levels.INFO)
							end
						end)
					end
				end
			)
		else
			-- No abstract candidate found; use the standard references lookup.
			require("telescope.builtin").lsp_references()
		end
	end)
end

return M
