-- vim: set foldmethod=marker :
return {
  'kndndrj/nvim-dbee',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  build = function()
    require('dbee').install()
  end,
  config = function()
    require('dbee').setup(--[[optional config]])
  end,
  keys = {
    { -- {{{ Toggle UI
      '<leader>Dt',
      function()
        require('dbee').toggle()
      end,
      desc = 'Toggle nvim-dbee UI',
    }, -- }}}
    { -- {{{ Load DB from json file in cwd
      '<leader>Dl',
      function()
        local cwd = vim.fn.getcwd()
        local db_files = vim.split(vim.fn.glob(cwd .. '/*.json'), '\n', { trimempty = true })

        vim.ui.select(db_files, {
          prompt = 'Select db file to load:',
          telescope = require('telescope.themes').get_cursor(),
          format_item = function(db_file)
            return db_file
          end,
        }, function(db_file, _)
          require('dbee').api.core.add_source(require('dbee.sources').FileSource:new(db_file))
        end)
      end,
      desc = 'Load database from json file',
    }, -- }}}
  },
}
