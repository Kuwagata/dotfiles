-- vim: set foldmethod=marker :
return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  opts = {
    enabled = false,
    disabled_keys = {
      ['<Up>'] = {},
      ['<Down>'] = {},
      ['<Left>'] = {},
      ['<Right>'] = {},
    },
  },
  keys = {
    { -- {{{ Toggle hardtime
      '<leader>th',
      function()
        require('hardtime').toggle()
      end,
      desc = 'Toggle hardtime.nvim',
    }, -- }}}
  },
}
