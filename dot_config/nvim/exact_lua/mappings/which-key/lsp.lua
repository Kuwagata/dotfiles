local mappings_group = vim.api.nvim_create_augroup('UserLspMappings', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = mappings_group,
  callback = function(args)
    local format_func = function()
      vim.lsp.buf.format { async = true }
    end

    local list_workspaces_func = function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    require('which-key').register({
      l = {
        name = 'LSP',
        c = { vim.lsp.buf.code_action, 'Code action', mode = { 'v', 'n' } },
        K = { vim.lsp.buf.hover, 'Hover menu' },
        s = { vim.lsp.buf.signature_help, 'Signature help' },
        R = { vim.lsp.buf.rename, 'Rename' },
        t = { vim.lsp.buf.type_definition, 'Type definition' },
        f = {
          name = 'Find',
          d = {
            function()
              return require('telescope.builtin').lsp_document_symbols()
            end,
            'Document symbols',
          },
          w = {
            function()
              return require('telescope.builtin').lsp_workspace_symbols()
            end,
            'Workspace symbols',
          },
          W = {
            function()
              return require('telescope.builtin').lsp_dynamic_workspace_symbols()
            end,
            'Dynamic workspace symbols',
          },
          r = {
            function()
              return require('telescope.builtin').lsp_references()
            end,
            'References',
          },
          i = {
            function()
              return require('telescope.builtin').lsp_incoming_calls()
            end,
            'Incoming calls',
          },
          o = {
            function()
              return require('telescope.builtin').lsp_outgoing_calls()
            end,
            'Outgoing calls',
          },
        },
        g = {
          name = 'Go to',
          D = { vim.lsp.buf.declaration, 'Go to declaration' },
          d = { vim.lsp.buf.definition, 'Go to definition' },
          i = { vim.lsp.buf.implementation, 'Go to implementation' },
        },
        w = {
          name = 'Workspace',
          f = { format_func, 'Format' },
          a = { vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
          r = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
          l = { list_workspaces_func, 'List workspace folders' },
        },
      },
    }, { prefix = '<leader>', buffer = args.buf, silent = true })
  end,
})
