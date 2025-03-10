return {
	"f-person/git-blame.nvim",
	opts = {
		enabled = true,
		date_format = "%r",
		virtual_text_column = 1,
	},
	keys = {
		{ "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle git blame text" },
	},
}
