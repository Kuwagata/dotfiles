-- vim: set foldminlines=1 foldmethod=marker :
return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = 'make install_jsregexp',
  opts = {
    link_children = true,
    exit_roots = true,
    update_events = { 'TextChangedI' },
    snip_env = { -- {{{
      s = function(...)
        local snip = require('luasnip').s(...)
        -- we can't just access the global `ls_file_snippets`, since it will be
        -- resolved in the environment of the scope in which it was defined.
        table.insert(getfenv(2).ls_file_snippets, snip)
      end,
      parse = function(...)
        local snip = require('luasnip').parser.parse_snippet(...)
        table.insert(getfenv(2).ls_file_snippets, snip)
      end,
      k = function()
        return require('luasnip.nodes.key_indexer').new_key
      end,
    }, -- }}}
  },
  config = function(_, opts) -- {{{
    require('luasnip').setup(opts)
    require('luasnip.loaders.from_lua').load {
      paths = './lua/plugin_configs/luasnip/snippets/lua',
      fs_event_providers = { libuv = true },
    }
  end, -- }}}
  keys = {
    { -- {{{ Expand snippet
      '<C-S>',
      function()
        require('luasnip').expand()
      end,
      desc = 'Expand snippet',
      mode = 'i',
      silent = true,
    }, -- }}}
    { -- {{{ Go to previous snippet input
      '<C-H>',
      function()
        require('luasnip').jump(-1)
      end,
      desc = 'Go to previous snippet input',
      mode = { 'i', 's' },
      silent = true,
    }, -- }}}
    { -- {{{ Go to next snippet input
      '<C-L>',
      function()
        require('luasnip').jump(1)
      end,
      desc = 'Go to next snippet input',
      mode = { 'i', 's' },
      silent = true,
    }, -- }}}
    { -- {{{ Change snippet choice node
      '<C-E>',
      function()
        local ls = require('luasnip')
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,
      desc = 'Change snippet choice node.',
      mode = { 'i', 's' },
      silent = true,
    }, -- }}}
    { -- {{{ Grow dynamic node
      '<C-.>',
      function()
        local h = require('../plugin_configs/luasnip/helpers')
        h.dynamic_node.external_update('grow')
      end,
      desc = 'Grow dynamic node',
      mode = { 'i', 's' },
      silent = true,
    }, -- }}}
    { -- {{{ Shrink dynamic node
      '<C-,>',
      function()
        local h = require('../plugin_configs/luasnip/helpers')
        h.dynamic_node.external_update('shrink')
      end,
      desc = 'Shrink dynamic node',
      mode = { 'i', 's' },
      silent = true,
    }, -- }}}
    { -- {{{ Switch dynamic node
      '<C-/>',
      function()
        local h = require('../plugin_configs/luasnip/helpers')
        h.dynamic_node.external_update('toggle')
      end,
      desc = 'Switch dynamic node',
      mode = { 'i', 's' },
      silent = true,
    }, -- }}}
  },
}
