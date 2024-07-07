-- vim: set foldmethod=marker :

-- Completion navigation for insert mode
local function popup_menu_key(when_visible, when_not_visible)
  return function()
    return vim.fn.pumvisible() == 1 and when_visible or when_not_visible
  end
end

vim.keymap.set('i', '<Tab>', popup_menu_key('<C-n>', '<Tab>'), { desc = 'Smart tab forward', expr = true })
vim.keymap.set('i', '<S-Tab>', popup_menu_key('<C-p>', '<S-Tab>'), { desc = 'Smart tab backward', expr = true })
vim.keymap.set(
  { 'i', 'n', 'c' },
  '<CR>',
  popup_menu_key('<C-y>', '<CR>'),
  { desc = 'Smart select popup menu item', expr = true }
)

-- Watch out that this doesn't conflict with fcitx (language input framework)
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { desc = 'OmniFunc' })

-- Shift lines up/down
-- Note: The '==' and 'gv=gv' help to match the indent of moved lines
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', { desc = 'Shift line down', silent = true })
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==', { desc = 'Shift line up', silent = true })
vim.keymap.set('i', '<C-j>', '<Esc>:m .+1<CR>==', { desc = 'Shift line down', silent = true })
vim.keymap.set('i', '<C-k>', '<Esc>:m .-2<CR>==', { desc = 'Shift line up', silent = true })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { desc = 'Shift selection down', silent = true })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { desc = 'Shift selection up', silent = true })

-- Easy visual indent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
