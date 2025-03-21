return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		-- For blink.cmp's completion
		-- source
		dependencies = {
			"catppuccin/nvim",
			-- "saghen/blink.cmp"
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = { "markdown" },
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	},
	{ "zhaozg/vim-diagram" },
}
