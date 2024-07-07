-- vim: set foldmethod=marker :
return {
  'ravibrock/spellwarn.nvim',
  enabled = false,
  event = 'VeryLazy',
  config = true,
  init = function(_)
    vim.opt.spell = true
    vim.opt.spelllang = 'en'
  end,
}
