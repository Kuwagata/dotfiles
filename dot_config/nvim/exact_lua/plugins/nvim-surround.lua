-- vim: set foldmethod=marker :
return {
  'kylechui/nvim-surround',
  event = 'VeryLazy',
  opts = {},
  keys = {
    { 'ys', desc = 'Surround with ...' },
    { 'ds', desc = 'Remove surrounding ...' },
    { 'cs', desc = 'Change surrounding ...' },
  },
}
