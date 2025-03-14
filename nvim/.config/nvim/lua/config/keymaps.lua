vim.keymap.set("n", "<leader>co", "<cmd>%bd|e#<CR>", { desc = "Close all other buffers" })
vim.keymap.set("n", "<leader>++", '<cmd>let @+=@"<CR>', { desc = "Copy current yanked content to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
