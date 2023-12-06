require("mappings/windows")
require("mappings/editing")

-- Pick one of these two, depending on whether you want to use which-key
require("mappings/which-key")
--require('mappings/lsp')

vim.keymap.set("i", "kj", "<esc>", { desc = "Ergonomic escape" })
vim.keymap.set("t", "kj", "<C-\\><C-n>", { desc = "Ergonomic escape (terminal mode)" })
vim.keymap.set("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>u", ":Lazy update<CR>", { desc = "Update packages", silent = true })
vim.keymap.set("n", "<C-l>", "<cmd>noh<CR>", { desc = "Clear highlights", silent = true })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })
