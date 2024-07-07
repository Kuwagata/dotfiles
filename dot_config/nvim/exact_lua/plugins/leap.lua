-- vim: set foldmethod=marker :
return {
  'ggandor/leap.nvim',
  config = function()
    require('leap').add_default_mappings()
  end,
}
