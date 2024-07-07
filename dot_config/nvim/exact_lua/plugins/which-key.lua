-- vim: set foldmethod=marker :
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
  config = function(_, opts)
    local presets = require('which-key.plugins.presets')
    -- Can't seem to set this the normal way using register()
    presets.operators['<C-\\>'] = 'Terminal'
    require('which-key').setup(opts)
  end,
}
