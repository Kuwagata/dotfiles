-- Completion navigation for insert mode
local function smart_tab()
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end

local function smart_shift_tab()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end

vim.keymap.set("i", "<Tab>", smart_tab, { desc = "Smart tab forward", expr = true })
vim.keymap.set("i", "<S-Tab>", smart_shift_tab, { desc = "Smart tab backward", expr = true })

-- Watch out that this doesn't conflict with fcitx (language input framework)
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { desc = "OmniFunc" })

-- Shift lines up/down
-- Note: The '==' and 'gv=gv' help to match the indent of moved lines
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Shift line down", silent = true })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Shift line up", silent = true })
vim.keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==", { desc = "Shift line down", silent = true })
vim.keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==", { desc = "Shift line up", silent = true })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Shift selection down", silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Shift selection up", silent = true })

-- Easy visual indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
