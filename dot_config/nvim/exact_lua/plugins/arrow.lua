-- vim: set foldmethod=marker :
return {
  'otavioschwanck/arrow.nvim',
  opts = {
    show_icons = true,
    leader_key = '<C-e>',
    buffer_leader_key = '<C-s>', -- Per Buffer Mappings
  },
  keys = {
    {
      '<C-e>',
      mode = { 'n', 'i', 't', 'v' },
      desc = 'Activate arrow UI',
    },
    {
      '<C-d>',
      mode = { 'n', 'i', 't', 'v' },
      desc = 'Activate arrow buffer UI',
    },
  },
}
