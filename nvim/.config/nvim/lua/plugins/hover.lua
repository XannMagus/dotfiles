---@diagnostic disable: missing-parameter
return {
	"lewis6991/hover.nvim",
	opts = {
		init = function()
			require("hover.providers.lsp")
			require("hover.providers.diagnostic")
		end,
		title = true,
		preview_window = true,
        preview_opts = {}
	},
	keys = {
		{
			"K",
			function()
				require("hover").hover()
			end,
			desc = "Show hover",
		},
	},
}
