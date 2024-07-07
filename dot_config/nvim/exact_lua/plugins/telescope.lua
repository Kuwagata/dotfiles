-- vim: set foldmethod=marker :
local close = function(...)
  return require('telescope.actions').close(...)
end

local open_in_trouble = function(...)
  return require('trouble.sources.telescope').open(...)
end

local add_to_trouble = function(...)
  return require('trouble.sources.telescope').add(...)
end

return {
  { -- {{{ Telescope
    'nvim-telescope/telescope.nvim',
    lazy = true,
    branch = '0.1.x',
    dependencies = { -- {{{
      'folke/trouble.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    }, -- }}}
    config = function(_, opts) -- {{{
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('fzf')
    end, -- }}}
    opts = {
      defaults = { -- {{{
        mappings = {
          n = {
            ['q'] = close,
            ['<c-t>'] = open_in_trouble,
            ['<c-a>'] = add_to_trouble,
            ['<space>'] = {
              'toggle_selection',
              type = 'action_key',
              opts = { nowait = true, silent = true },
            },
          },
          i = {
            ['<c-t>'] = open_in_trouble,
            ['<c-a>'] = add_to_trouble,
          },
        },
      }, -- }}}
      extensions = { -- {{{
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        },
        frecency = {
          workspaces = {
            ['projects'] = '/home/john/Projects',
            ['documents'] = '/home/john/Documents',
          },
        },
        file_browser = {},
      }, -- }}}
    },
    keys = {
      -- {{{  Defined in mappings/which-key.lua for when LSP loads <leader>l_
      '<leader>lfd',
      '<leader>lfw',
      '<leader>lfW',
      '<leader>lfr',
      '<leader>lfi',
      '<leader>lfo',
      -- }}}
      { -- {{{ Find files           <leader>ff
        '<leader>ff',
        function()
          return require('telescope.builtin').find_files()
        end,
        desc = 'Files',
      }, -- }}}
      { -- {{{ Find old files       <leader>fo
        '<leader>fo',
        function()
          return require('telescope.builtin').find_oldfiles()
        end,
        desc = 'Old files',
      }, -- }}}
      { -- {{{ Find sibling files   <leader>fs
        '<leader>fs',
        function()
          return require('telescope.builtin').find_files { cwd = vim.fn.expand('%:p:h') }
        end,
        desc = 'Sibling files',
      }, -- }}}
      { -- {{{ Find buffers         <leader>fb
        '<leader>fb',
        function()
          return require('telescope.builtin').buffers {
            ignore_current_buffer = true,
            sort_mru = true,
          }
        end,
        desc = 'Buffers',
      }, -- }}}
      { -- {{{ Grep                 <leader>fg
        '<leader>fg',
        function()
          return require('telescope.builtin').live_grep()
        end,
        desc = 'Grep',
      }, -- }}}
      { -- {{{ Diagnostics          <leader>fd
        '<leader>fd',
        function()
          return require('telescope.builtin').diagnostics()
        end,
        desc = 'Diagnostics',
      }, -- }}}
      { -- {{{ Treesitter objects   <leader>ft
        '<leader>ft',
        function()
          return require('telescope.builtin').treesitter()
        end,
        desc = 'Treesitter',
      }, -- }}}
      { -- {{{ Help files           <leader>fh
        '<leader>fh',
        function()
          return require('telescope.builtin').help_tags()
        end,
        desc = 'Help',
      }, -- }}}
      { -- {{{ Man pages            <leader>fm
        '<leader>fm',
        function()
          return require('telescope.builtin').man_pages()
        end,
        desc = 'Man pages',
      }, -- }}}
      { -- {{{ Jump List            <leader>j
        '<leader>j',
        function()
          return require('telescope.builtin').jumplist()
        end,
        desc = 'Jump List',
      }, -- }}}
      { -- {{{ Command history      <leader>fHc
        '<leader>fHc',
        function()
          return require('telescope.builtin').command_history()
        end,
        desc = 'Command history',
      }, -- }}}
      { -- {{{ Search history       <leader>fHs
        '<leader>fHs',
        function()
          return require('telescope.builtin').search_history()
        end,
        desc = 'Search history',
      }, -- }}}
      { -- {{{ Git Files            <leader>fGf
        '<leader>fGf',
        function()
          return require('telescope.builtin').git_files()
        end,
        desc = 'Search history',
      }, -- }}}
      { -- {{{ Git Status           <leader>fGf
        '<leader>fGs',
        function()
          return require('telescope.builtin').git_status()
        end,
        desc = 'Git status',
      }, -- }}}
      { -- {{{ Git Stash            <leader>fGf
        '<leader>fGS',
        function()
          return require('telescope.builtin').git_stash()
        end,
        desc = 'Git Stash',
      }, -- }}}
    },
  }, -- }}}
  { -- {{{ Telescope-fzf-native
    'nvim-telescope/telescope-fzf-native.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    lazy = true,
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  }, -- }}}
  { -- {{{ Telescope-frecency
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('telescope').load_extension('frecency')
    end,
    keys = {
      { -- {{{ Find recent files
        '<leader>fr',
        function()
          return require('frecency').start()
        end,
        desc = 'Telescope frecency',
      }, -- }}}
    },
  }, -- }}}
  { -- {{{ Telescope-git-diffs
    'Kuwagata/telescope-git-diffs.nvim',
    dev = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'sindrets/diffview.nvim',
    },
    config = function()
      require('telescope').load_extension('git_diffs')
    end,
    keys = {
      { -- {{{ Diff commits
        '<leader>fGd',
        function()
          require('telescope').extensions.git_diffs.diff_commits()
        end,
        desc = 'Telescope git diffview',
      }, -- }}}
    },
  }, -- }}}
}
