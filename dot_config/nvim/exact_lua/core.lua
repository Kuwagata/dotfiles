vim.g.mapleader = ' '
vim.opt.undofile = true

-- Indentation
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Wildcard Expansion
vim.opt.wildcharm = string.byte(vim.api.nvim_replace_termcodes('<C-Z>', true, true, true))
-- vim.opt.wildcharm = vim.keycode("<C-Z>") -- Make sure this works, but also <C-Z> suspends process in zsh
vim.opt.wildignorecase = true
vim.opt.wildignore = {
  '*.swp',
  '*.bak',
  '*.pyc',
  '*.class',
  '*.sln',
  '*.Master',
  '*.csproj',
  '*.csproj.user',
  '*.cache',
  '*.so',
  '*.dll',
  '*.pdb',
  '*.min.*',
  '*/.git/**/*',
  '*/.hg/**/*',
  '*/.svn/**/*',
  'tags',
  '*.tar.*',
}

-- UI
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.showtabline = 1
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.foldminlines = 3
vim.opt.foldcolumn = '3'

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('termoptions', {}),
  callback = function(_)
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
  desc = 'Disable line numbers for terminal windows',
})

-- Completion
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.shortmess:append('c')

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('EditHighlighting', {}),
  callback = function(_)
    vim.highlight.on_yank { higroup = 'Visual', timeout = 300 }
  end,
})
