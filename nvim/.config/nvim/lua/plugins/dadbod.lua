return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	keys = {
		{
			"<leader>db",
			"<cmd>DBUI<CR>",
			desc = "[D]atabase [B]rowser",
		},
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
	end,
}
