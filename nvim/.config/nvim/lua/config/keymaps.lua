vim.keymap.set("n", "<leader>co", "<cmd>%bd|e#<CR>", { desc = "Close all other buffers" })
vim.keymap.set("n", "<leader>++", '<cmd>let @+=@"<CR>', { desc = "Copy current yanked content to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>p", '"0p', { desc = "Paste last yanked text" })

vim.keymap.set("n", "<leader>dt", function()
	local clients = require("neotest").state.clients() or {}
	for client in clients do
		local tests = client:get_positions()

		local function print_ids(positions)
			for id, pos in pairs(positions) do
				if type(pos) == "table" and pos.id then
					print(pos.id)
				elseif type(pos) == "table" then
					print_ids(pos)
				end
			end
		end

		print_ids(tests)
	end
end)
