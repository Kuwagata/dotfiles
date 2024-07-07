-- vim: set foldmethod=marker :
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      hijack_netrw_behavior = 'disabled',
    },
    event_handlers = {
      {
        event = 'neo_tree_buffer_leave',
        handler = function(_)
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
    },
  },
  keys = {
    {
      '<C-F>',
      function()
        require('neo-tree.command').execute { toggle = true }
      end,
      mode = { 'n', 'i', 'v' },
      desc = 'Toggle neo-tree',
    },
  },
}
