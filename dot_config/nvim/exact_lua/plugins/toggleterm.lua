-- vim: set foldmethod=marker :
local vertical_size_default = 100

-- Select from all terminals to apply an action to one
local term_action = function(prompt, callback) -- {{{
  return function()
    local terminals = require('toggleterm.terminal').get_all()
    if #terminals == 0 then
      vim.schedule(function()
        vim.notify('No toggleterms are open yet', vim.log.levels.INFO, { title = 'Toggleterm' })
      end)
      return
    end
    vim.ui.select(terminals, {
      prompt = prompt,
      telescope = require('telescope.themes').get_cursor(),
      format_item = function(term)
        return term.id .. ': ' .. term:_display_name()
      end,
    }, callback)
  end
end
-- }}}

-- {{{ Resize helpers
local resize_open = function(func)
  local bufresize = require('bufresize')
  bufresize.block_register()
  func()
  bufresize.resize_open()
  if vim.api.nvim_get_mode().mode ~= 't' then
    vim.cmd([[execute "normal! i"]])
  end
end

local resize_close = function(func)
  local bufresize = require('bufresize')
  bufresize.block_register()
  func()
  bufresize.resize_close()
end
-- }}}

-- {{{ Toggleterm helpers
local new_term = function(dir, size) -- {{{
  return function()
    local term = require('toggleterm.terminal').Terminal:new { direction = dir }
    resize_open(function()
      term:toggle(size)
    end)
  end
end -- }}}
local new_horizontal_term = new_term('horizontal')
local new_vertical_term = new_term('vertical', vertical_size_default)
local new_term_menu = function() -- {{{
  vim.ui.select({
    'horizontal',
    'vertical',
    'float',
    'tab',
  }, {
    prompt = 'Select layout',
    telescope = require('telescope.themes').get_cursor(),
  }, function(selected, idx)
    if idx ~= nil then
      vim.ui.input({ prompt = 'Please set a name for the terminal (empty for default)' }, function(name)
        if name and #name == 0 then
          name = nil
        end
        local size = nil
        if selected == 'vertical' then
          size = vertical_size_default
        end
        resize_open(function()
          require('toggleterm.terminal').Terminal
            :new({ display_name = name, direction = selected })
            :toggle(size, selected)
        end)
      end)
    end
  end)
end -- }}}
local open_term = term_action('Please select a terminal to open or focus: ', function(term, _) -- {{{
  if term:is_open() then
    term:focus()
  else
    local size = nil
    if term.direction == 'vertical' then
      size = vertical_size_default
    end
    resize_open(function()
      term:open(size)
    end)
  end
end) -- }}}
local close_term = function() -- {{{
  local terms = require('toggleterm.terminal')
  local term_id = terms.get_focused_id()
  if term_id then
    resize_close(function()
      terms.get(term_id):close()
    end)
  end
end -- }}}
local rename_term = function() -- {{{
  local terms = require('toggleterm.terminal')
  local term_id = terms.get_focused_id()
  if term_id then
    local term = terms.get(term_id)
    vim.ui.input({ prompt = 'Please set a name for the terminal (empty for default)' }, function(name)
      term.display_name = name
    end)
  end
end -- }}}
local toggle_term = term_action('Please select a terminal to toggle: ', function(term, _) -- {{{
  if term then
    if term:is_open() then
      resize_close(function()
        term:toggle()
      end)
    else
      resize_open(function()
        term:toggle()
      end)
    end
  end
end) -- }}}
-- }}}

-- {{{ Lazygit helpers
local lazygit = nil
local _lazyget_toggle = function()
  if not lazygit then
    lazygit = require('toggleterm.terminal').Terminal:new {
      cmd = 'lazygit',
      dir = 'git_dir',
      direction = 'float',
      hidden = true,
      float_opts = {
        border = 'double',
      },
      on_open = function(term)
        vim.cmd('startinsert!')
        vim.keymap.set({ 'i', 't', 'v' }, 'k', 'k', {
          desc = 'Short-circuit the ergonomic escape sequence: kj',
          buffer = term.bufnr,
          noremap = true,
          nowait = true,
          silent = true,
        })
      end,
      on_close = function(_)
        vim.cmd('startinsert!')
      end,
    }
  end
  lazygit:toggle()
end -- }}}

local map_term_pair = function(abbrev_lhs, rhs, desc)
  return {
    {
      [[<c-\>]] .. abbrev_lhs,
      rhs,
      desc = desc,
      silent = true,
      mode = { 'n', 'i', 'v' },
    },
    {
      'y' .. abbrev_lhs,
      rhs,
      desc = desc .. ' (terminal)',
      silent = true,
      mode = { 't' },
    },
  }
end

return {
  'akinsho/toggleterm.nvim',
  version = '*',
  dependencies = {
    'kwkarlwang/bufresize.nvim', -- To better resize windows when toggling
    'stevearc/dressing.nvim', -- For fancy UIs and custom commands
  },
  opts = {
    persist_size = false,
  },
  keys = vim
    .iter({
      map_term_pair('tt', vim.schedule_wrap(toggle_term), 'Toggle terminal'),
      map_term_pair('to', open_term, 'Open terminal'),
      map_term_pair('tc', close_term, 'Close focused terminal'),
      map_term_pair('tr', rename_term, 'Rename terminal'),
      map_term_pair('tn', new_term_menu, 'New terminal'),
      map_term_pair('ts', new_horizontal_term, 'New horizontal terminal'),
      map_term_pair('tv', new_vertical_term, 'New vertical terminal'),
      map_term_pair('tl', _lazyget_toggle, 'New lazygit terminal'),
    })
    :flatten()
    :totable(),
}

-- return {
--   'akinsho/toggleterm.nvim',
--   version = '*',
--   dependencies = {
--     'kwkarlwang/bufresize.nvim', -- To better resize windows when toggling
--     'stevearc/dressing.nvim', -- For fancy UIs and custom commands
--   },
--   opts = {
--     persist_size = false,
--   },
--   keys = {
--     { -- {{{ Toggle terminal from menu
--       [[<c-\>tt]],
--       vim.schedule_wrap(toggle_term),
--       desc = 'Toggle terminal',
--       silent = true,
--       mode = { 'n', 'i', 'v' },
--     },
--     {
--       'ytt',
--       vim.schedule_wrap(toggle_term),
--       desc = 'Toggle terminal',
--       silent = true,
--       mode = { 't' },
--     }, -- }}}
--     { -- {{{ Open terminal from menu
--       [[<c-\>to]],
--       open_term,
--       desc = 'Open terminal',
--       silent = true,
--       mode = { 'n', 'v', 'i' },
--     },
--     {
--       'yto',
--       open_term,
--       desc = 'Open terminal',
--       silent = true,
--       mode = { 't' },
--     }, -- }}}
--     { -- {{{ Close focused terminal
--       [[<c-\>tc]],
--       close_term,
--       desc = 'Close focused terminal',
--       silent = true,
--       mode = { 'n', 'i', 'v' },
--     },
--     {
--       'ytc',
--       close_term,
--       desc = 'Close focused terminal',
--       silent = true,
--       mode = { 't' },
--     }, -- }}}
--     -- { -- {{{ Toggle all terminals
--     -- 	[[<c-\>ta]],
--     -- 	vim.schedule_wrap(function()
--     -- 		if require("toggleterm.ui").find_open_windows() then
--     -- 			local bufresize = require("bufresize")
--     -- 			bufresize.block_register()
--     -- 			require("toggleterm").toggle_all()
--     -- 			bufresize.resize_close()
--     -- 		else
--     -- 			require("toggleterm").toggle_all()
--     -- 		end
--     -- 	end),
--     -- 	desc = "Toggle all",
--     -- 	silent = true,
--     -- 	mode = { "n", "v", "i" },
--     -- },
--     -- {
--     -- 	"yta",
--     -- 	[[<c-\><c-o><c-\>ta]],
--     -- 	desc = "Toggle all",
--     -- 	silent = true,
--     -- 	mode = { "t" },
--     -- }, -- }}}
--     { -- {{{ Rename focused terminal
--       [[<c-\>tr]],
--       rename_term,
--       desc = 'Rename terminal',
--       silent = true,
--       mode = { 'n', 'v', 'i' },
--     },
--     {
--       'ytr',
--       rename_term,
--       desc = 'Rename terminal',
--       silent = true,
--       mode = { 't' },
--     }, -- }}}
--     { -- {{{ New terminal from menu
--       [[<c-\>tn]],
--       new_term_menu,
--       desc = 'New terminal',
--       silent = true,
--       mode = { 'n', 'i', 'v' },
--     },
--     {
--       'ytn',
--       new_term_menu,
--       desc = 'New terminal',
--       silent = true,
--       mode = { 't' },
--     }, -- }}}
--     { -- {{{ New horizontal terminal
--       [[<c-\>ts]],
--       new_horizontal_term,
--       desc = 'New terminal (horizontal)',
--       silent = true,
--       mode = { 'n', 'i', 'v' },
--     },
--     {
--       'yts',
--       new_horizontal_term,
--       desc = 'New terminal (horizontal)',
--       silent = true,
--       mode = { 't' },
--     }, -- }}}
--     { -- {{{ New vertical terminal
--       [[<c-\>tv]],
--       new_vertical_term,
--       desc = 'New terminal (vertical)',
--       silent = true,
--       mode = { 'n', 'i', 'v' },
--     },
--     {
--       'ytv',
--       new_vertical_term,
--       desc = 'New terminal (vertical)',
--       silent = true,
--       mode = { 't' },
--     }, -- }}}
--     { -- {{{ Toggle lazygit
--       [[<c-\>tl]],
--       _lazyget_toggle,
--       desc = 'Toggle lazygit',
--       silent = true,
--       mode = { 'n', 'i', 'v' },
--     },
--     {
--       'ytl',
--       [[<c-\><c-o><c-\>tl]],
--       desc = 'Toggle lazygit',
--       silent = true,
--       mode = { 't' },
--     }, -- }}}
--   },
-- }
