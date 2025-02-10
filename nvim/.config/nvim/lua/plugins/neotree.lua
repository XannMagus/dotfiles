return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            "<leader>n",
            function()
                require("neo-tree.command").execute({ toggle = true, reveal = true })
            end,
            desc = "Show Neotree",
        },
    },
    opts = {
        close_if_last_window = true,
        event_handlers = {
            {
                event = "file_open_requested",
                handler = function()
                    require("neo-tree.command").execute({ action = "close" })
                end,
            },
        },
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = true,
            },
            follow_current_file = {
                enabled = true,
            },
        },
        window = {
            position = "left",
        },
    },
}
