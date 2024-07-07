-- vim: set foldmethod=marker :
return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  keys = {
    { -- {{{ Toggle trouble (default)
      '<leader>xx',
      function()
        require('trouble').toggle { mode = 'diagnostics', focus = true }
      end,
      desc = 'Diagnostics (Trouble)',
    }, -- }}}
    { -- {{{ Toggle trouble for current buffer
      '<leader>xX',
      function()
        require('trouble').toggle { mode = 'diagnostics', filter = { buf = 0 }, focus = true }
      end,
      desc = 'Buffer Diagnostics (Trouble)',
    }, -- }}}
    { -- {{{ Quickfix
      '<leader>xq',
      function()
        require('trouble').toggle { mode = 'qflist', focus = true }
      end,
      desc = 'Quickfix (Trouble)',
    }, -- }}}
    { -- {{{ Loc list
      '<leader>xl',
      function()
        require('trouble').toggle { mode = 'loclist', focus = true }
      end,
      desc = 'Location list (Trouble)',
    }, -- }}}
    { -- {{{ LSP references
      '<leader>xL',
      function()
        require('trouble').toggle { mode = 'lsp', focus = false }
      end,
      desc = 'LSP References (Trouble)',
    }, -- }}}
    { -- {{{ Symbols
      '<leader>xs',
      function()
        require('trouble').toggle { mode = 'symbols', focus = false, win = { position = 'bottom' } }
      end,
      desc = 'Symbols (Trouble)',
    }, -- }}}
  },
}
