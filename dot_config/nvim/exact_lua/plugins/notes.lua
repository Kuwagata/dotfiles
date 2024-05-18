-- vim: set foldmethod=marker :
return {
  'Kuwagata/notes.nvim',
  -- enabled = false,
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  dev = true,
  lazy = false,
  opts = {},
  keys = {
    {
      [[<leader>n]],
      function()
        vim.schedule(require('notes').open_browser)
      end,
      desc = 'TEST: Open notes browser',
      silent = true,
      mode = { 'n', 'v' },
    },
  },
}
