return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            defaults = {
                initial_mode = "normal",
            },
            pickers = {
                find_files = {
                    initial_mode = "insert",
                },
                live_grep = {
                    initial_mode = "insert",
                },
                help_tags = {
                    initial_mode = "insert",
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

            vim.keymap.set("n", "<C-k>", builtin.keymaps, { desc = "Show Keymaps" })

            vim.keymap.set("n", "<c-f>", builtin.grep_string, { desc = "Find in files" })

            vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Goto definition" })
            vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "Goto type" })
            vim.keymap.set("n", "gu", builtin.lsp_references, { desc = "See usages" })
            vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "See implementations" })

            vim.keymap.set("n", "<leader>fb", function()
                builtin.buffers({
                    initial_mode = "normal",
                    attach_mappings = function(prompt_bufnr, map)
                        local action_state = require("telescope.actions.state")
                        local delete_buf = function()
                            local current_picker = action_state.get_current_picker(prompt_bufnr)
                            current_picker:delete_selection(function(selection)
                                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                            end)
                        end

                        map("n", "<C-S-d>", delete_buf)

                        return true
                    end,
                }, {})
            end, { desc = "Telescope buffers" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            -- This is your opts table
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
}
