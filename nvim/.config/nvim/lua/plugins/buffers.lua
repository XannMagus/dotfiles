return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup({})

			-- basic telescope configuration
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end, { desc = "[Harpoon] Add current buffer" })
			vim.keymap.set("n", "<leader>hr", function()
				harpoon:list():remove()
			end, { desc = "[Harpoon] Remove current buffer" })
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "[Harpoon] Open harpoon list" })

			vim.keymap.set("n", "<C-u>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set("n", "<C-i>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set("n", "<C-o>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set("n", "<C-p>", function()
				harpoon:list():select(4)
			end)
			vim.keymap.set("n", "<C-M-u>", function()
				harpoon:list():replace_at(1)
			end)
			vim.keymap.set("n", "<C-M-i>", function()
				harpoon:list():replace_at(2)
			end)
			vim.keymap.set("n", "<C-M-o>", function()
				harpoon:list():replace_at(3)
			end)
			vim.keymap.set("n", "<C-M-p>", function()
				harpoon:list():replace_at(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-S-P>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-S-N>", function()
				harpoon:list():next()
			end)
		end,
	},
	{
		"leath-dub/snipe.nvim",
		keys = {
			{
				"gb",
				function()
					require("snipe").open_buffer_menu()
				end,
				desc = "Open Snipe buffer menu",
			},
		},
		opts = {},
	},
}
