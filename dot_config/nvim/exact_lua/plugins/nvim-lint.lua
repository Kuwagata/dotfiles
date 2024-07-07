-- vim: set foldmethod=marker :
return {
  'mfussenegger/nvim-lint',
  event = 'VeryLazy',
  opts = {
    bash = { 'shellcheck' },
    c = { 'clangtidy', 'cpplint', 'cppcheck' },
    cpp = { 'clangtidy', 'cpplint', 'cppcheck' },
    css = { 'stylelint' },
    go = { 'golangcilint' },
    html = { 'tidy' },
    javascript = { 'eslint' },
    latex = { 'chktex' },
    lua = { 'luacheck' },
    python = { 'ruff', 'bandit' },
    sh = { 'shellcheck' },
    sql = { 'sqlfluff' },
    typescript = { 'eslint' },
    zsh = { 'zsh' },
  },
  config = function(_, opts)
    local lint = require('lint')
    lint.linters_by_ft = opts

    local eslint_d = lint.linters.eslint_d
    eslint_d.env = {
      NPM_CONFIG_USERCONFIG = vim.env.NPM_CONFIG_USERCONFIG,
      ESLINT_USE_FLAT_CONFIG = 'true',
    }

    vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufWritePost' }, {
      group = vim.api.nvim_create_augroup('linting', {}),
      callback = function(_)
        require('lint').try_lint()
      end,
    })
  end,
}
