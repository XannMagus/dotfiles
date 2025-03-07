vim.keymap.set("n", "<leader>ru", require("smart_refs").smart_references, { desc = "Smart Find References" })
vim.keymap.set("n", "<leader>co", "<cmd>%bd|e#<CR>", { desc = "Close all other buffers" })
