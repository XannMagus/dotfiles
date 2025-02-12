return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.phpcsfixer,
				null_ls.builtins.diagnostics.phpstan,
				null_ls.builtins.diagnostics.twigcs,
			},
		})
	end,
}
