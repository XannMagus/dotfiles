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
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.phpactor.setup({
                capabilities = capabilities,
                init_options = {
                    ["logging.enabled"] = true,
                    ["logging.level"] = "debug",
                    ["logging.path"] = "phpactor.log",
                },
            })
            lspconfig.psalm.setup({
                capabilities = capabilities,
            })
            lspconfig.yamlls.setup({
                capabilities = capabilities,
            })
            lspconfig.twiggy_language_server.setup({
                capabilities = capabilities,
                settings = {
                    twiggy = {
                        framework = "symfony",
                    },
                },
            })

            -- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })

            vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
            vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic" })

            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, { desc = "Format buffer" })
        end,
    },
}
