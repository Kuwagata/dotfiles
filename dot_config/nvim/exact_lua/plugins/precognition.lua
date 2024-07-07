-- vim: set foldmethod=marker :
return {
  'tris203/precognition.nvim',
  event = 'VeryLazy',
  opts = { startVisible = true },
  keys = {
    {
      '<leader>tp',
      function()
        require('precognition').toggle()
      end,
      mode = { 'n', 'v' },
      desc = 'Toggle precognition',
    },
    {
      '<leader>tP',
      function()
        require('precognition').peek()
      end,
      mode = { 'n', 'v' },
      desc = 'Toggle precognition (peek)',
    },
  },
}
