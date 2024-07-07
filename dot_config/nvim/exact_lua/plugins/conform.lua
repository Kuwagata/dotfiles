-- vim: set foldmethod=marker :

-- {{{ User command: Disable formatting
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})
-- }}}

-- {{{ User command: Enable formatting
vim.api.nvim_create_user_command('FormatEnable', function(args)
  if args.bang then
    -- FormatEnable! will enable formatting just for this buffer
    vim.b.disable_autoformat = false
  else
    vim.g.disable_autoformat = false
  end
end, {
  desc = 'Re-enable autoformat-on-save',
  bang = true,
})
-- }}}

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    formatters_by_ft = {
      bash = { 'shfmt' },
      c = { 'uncrustify' },
      cpp = { 'uncrustify' },
      cs = { 'uncrustify' },
      css = { 'biome' },
      go = { 'gofmt' },
      java = { 'uncrustify' },
      javascript = { 'biome' },
      json = { 'biome' },
      jsonc = { 'biome' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      rust = { 'rustfmt' },
      sh = { 'shfmt' },
      sql = { 'sqlfluff' },
      typescript = { 'biome' },
      xml = { 'xmllint' },
      yaml = { 'yamlfmt' },
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    notify_on_error = true,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  keys = {
    {
      '<leader>F',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
}
