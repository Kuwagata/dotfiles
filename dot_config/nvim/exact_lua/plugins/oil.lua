-- vim: set foldmethod=marker :
local utils = require('utils')

return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    columns = {
      'icon',
      'permissions',
      'size',
      'mtime',
    },
    delete_to_trash = true,
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    {
      '-',
      function()
        if not utils.string.startswith(vim.api.nvim_buf_get_name(0), 'term://') then
          require('oil').open()
        end
      end,
      desc = 'Open parent directory',
      mode = { 'v', 'x', 'n' },
    },
    {
      '_',
      function()
        if not utils.string.startswith(vim.api.nvim_buf_get_name(0), 'term://') then
          require('oil').toggle_float()
        end
      end,
      desc = 'Open parent directory',
      mode = { 'v', 'x', 'n' },
    },
  },
}
