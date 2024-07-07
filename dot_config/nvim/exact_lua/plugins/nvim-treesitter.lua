-- vim: set foldmethod=marker :
return {
  'nvim-treesitter/nvim-treesitter',
  name = 'nvim-treesitter',
  version = false,
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = { -- {{{ List of languages
      'bash',
      'c',
      'c_sharp',
      'cmake',
      'cpp',
      'css',
      'diff',
      'git_rebase',
      'gitattributes',
      'gitignore',
      'go',
      'html',
      'java',
      'javascript',
      'json',
      'latex',
      'lua',
      'make',
      'markdown',
      'markdown_inline',
      'php', -- Grammar has been acting weird https://github.com/nvim-treesitter/nvim-treesitter/issues/5962
      'php_only',
      'python',
      'pug',
      'racket',
      'rust',
      'scheme',
      'scss',
      'toml',
      'typescript',
      'yaml',
    }, -- }}}
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  end,
}
