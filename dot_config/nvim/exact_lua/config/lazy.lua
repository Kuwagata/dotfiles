-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('core')

require('lazy').setup {
  dev = {
    path = '~/Projects/Neovim',
    fallback = false,
  },
  spec = {
    { import = 'plugins' },
  },
  rocks = {
    hererocks = true,
  },
  install = { colorscheme = { 'habamax' } },
  checker = { enabled = true },
}

require('plugin_configs')
require('lsp')
require('mappings')
require('appearance')
