return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			ensure_installed = { "lua_ls", "phpactor", "psalm", "yamlls", "twiggy_language_server" },
			auto_install = true,
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			"neovim/nvim-lspconfig",
		},
		opts = {},
		config = function(_, opts)
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			require("ufo").setup(opts or {})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.enable("lua_ls")
			vim.lsp.config("phpactor", {
				init_options = {
					["logging.enabled"] = true,
					["logging.level"] = "debug",
					["logging.path"] = "phpactor.log",
				},
			})
			vim.lsp.enable("phpactor")
			-- lspconfig.psalm.setup({
			--     capabilities = capabilities,
			-- })
			vim.lsp.enable("yamlls")
			vim.lsp.config("twiggy_language_server", {
				settings = {
					twiggy = {
						framework = "symfony",
					},
				},
			})
			vim.lsp.enable("twiggy_language_server")

			-- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })

			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "Format buffer" })
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
		end,
	},
}
