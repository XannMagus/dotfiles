return {
	"ggandor/leap.nvim",
	dependencies = {
		"tpope/vim-repeat",
	},
	config = function()
		vim.keymap.set({ "n", "x", "o" }, "<leader>s", "<Plug>(leap-forward)")
		vim.keymap.set({ "n", "x", "o" }, "<leader>S", "<Plug>(leap-backward)")
	end,
}
