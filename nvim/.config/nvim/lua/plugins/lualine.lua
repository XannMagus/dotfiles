local options = require("vim.filetype.options")
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = "catppuccin",
		},
	},
}
