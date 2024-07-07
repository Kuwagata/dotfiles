-- vim: set foldmethod=marker :
return {
  'nvim-focus/focus.nvim',
  enabled = false,
  version = false,
  opts = { -- {{{
    commands = true,
    autoresize = { -- {{{
      -- enable = true,
      --minwidth = 10,
      --minheight = 10,
      -- width = 0,
      -- height = 0,
    }, -- }}}
    split = { -- {{{
      bufnew = false,
    }, -- }}}
    ui = { -- {{{
      number = false,
      relativenumber = false,
      hybridnumber = false,
      absolutenumber_unfocussed = false,
      cursorline = true,
      cursorcolumn = false,
      colorcolumn = {
        enable = false,
        list = '+1',
      },
      signcolumn = true,
      winhighlight = false,
    }, -- }}}
  }, -- }}}
  config = function(_, opts) -- {{{
    require('focus').setup(opts)

    local ignore_filetypes = {}
    local ignore_buftypes = { 'nofie', 'prompt', 'popup', 'terminal' }

    local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

    vim.api.nvim_create_autocmd('WinEnter', {
      group = augroup,
      callback = function(_)
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
          vim.w.focus_disable = true
        else
          vim.w.focus_disable = false
        end
      end,
      desc = 'Disable focus autoresize for BufType',
    })

    vim.api.nvim_create_autocmd('FileType', {
      group = augroup,
      callback = function(_)
        if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
          vim.b.focus_disable = true
        else
          vim.b.focus_disable = false
        end
      end,
      desc = 'Disable focus autoresize for FileType',
    })
  end, -- }}}
  keys = {
    { -- {{{ Split nicely
      '<leader>sn',
      function()
        local ignore_buftypes = { 'nofile', 'prompt', 'popup', 'terminal' }
        if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
          print(('Cannot split in %s'):format(vim.bo.buftype))
        else
          require('focus').split_nicely()
        end
      end,
      desc = 'Split nicely',
    }, -- }}}
    { -- {{{ Maximize focused window
      '<leader>sm',
      function()
        require('focus').focus_maximise()
      end,
      desc = 'Maximize focused window',
    }, -- }}}
    { -- {{{ Equalize windows
      '<leader>s=',
      function()
        require('focus').focus_equalise()
      end,
      desc = 'Equalize windows',
    }, -- }}}
    -- { -- {{{ Split left
    -- 	-- "<leader>sh",
    -- 	"<A-h>",
    -- 	function()
    -- 		require("focus").split_command("h")
    -- 	end,
    -- 	desc = "Split left",
    -- }, -- }}}
    -- { -- {{{ Split down
    -- 	-- "<leader>sj",
    -- 	"<A-j>",
    -- 	function()
    -- 		require("focus").split_command("j")
    -- 	end,
    -- 	desc = "Split down",
    -- }, -- }}}
    -- { -- {{{ Split up
    -- 	-- "<leader>sk",
    -- 	"<A-k>",
    -- 	function()
    -- 		require("focus").split_command("k")
    -- 	end,
    -- 	desc = "Split up",
    -- }, -- }}}
    -- { -- {{{ Split right
    -- 	-- "<leader>sl",
    -- 	"<A-l>",
    -- 	function()
    -- 		require("focus").split_command("l")
    -- 	end,
    -- 	desc = "Split right",
    -- }, -- }}}
  },
}
