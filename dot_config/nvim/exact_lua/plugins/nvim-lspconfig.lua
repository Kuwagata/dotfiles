-- vim: set foldmethod=marker :

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local nvim_lsp = require('lspconfig')
    nvim_lsp.bashls.setup {}
    nvim_lsp.clangd.setup {}
    nvim_lsp.cmake.setup {}
    nvim_lsp.cssls.setup { -- {{{ CSS LS Args
      init_options = {
        provideFormatter = false,
      },
    } -- }}}
    nvim_lsp.html.setup { -- {{{ HTML LS Args
      init_options = {
        configurationSection = { 'html', 'css', 'javascript' },
        embeddedLanguages = {
          css = true,
          javascript = true,
        },
        provideFormatter = false,
      },
    } -- }}}
    nvim_lsp.jsonls.setup { -- {{{ JSON LS Args
      init_options = {
        provideFormatter = false,
      },
    } -- }}}
    nvim_lsp.lua_ls.setup {}
    nvim_lsp.phpactor.setup {} -- Acting strangely with treesitter
    nvim_lsp.pug.setup {}
    nvim_lsp.pyright.setup {}
    nvim_lsp.rust_analyzer.setup {}
    nvim_lsp.texlab.setup {}
    -- nvim_lsp.tsserver.setup {}
    nvim_lsp.vtsls.setup {}
  end,
}
