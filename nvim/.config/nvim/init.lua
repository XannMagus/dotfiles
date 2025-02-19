require("vim-options")
require("config.lazy")

vim.keymap.set("n", "<leader>ru", require("smart_refs").smart_references, { desc = "Smart Find References" })
