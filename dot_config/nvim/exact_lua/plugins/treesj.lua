-- vim: set foldmethod=marker :
return {
  'Wansmer/treesj',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {},
  keys = {
    {
      '<leader>cj',
      function()
        require('treesj').toggle()
      end,
      desc = 'Split/Join',
    },
    {
      '<leader>cJ',
      function()
        require('treesj').toggle { split = { recursive = true } }
      end,
      desc = 'Split/Join (recursive)',
    },
  },
}
