-- vim: set foldmethod=marker :
local is_toggleterm_buffer = function(buf)
  local constants = require('toggleterm.constants')
  if vim.bo[buf].filetype == constants.FILETYPE or vim.b[buf].toggle_number ~= nil then
    return true
  end
  return false
end

local is_oil_buffer = function(buf)
  if vim.bo[buf].filetype == 'oil' then
    return true
  end
  return false
end

local cmd_group = vim.api.nvim_create_augroup('maximize_toggleterm', {})

-- {{{ Autocommand: Maximize
vim.api.nvim_create_autocmd('User', {
  group = cmd_group,
  pattern = 'WindowMaximizeStart',
  callback = function(_)
    local focused_win = vim.api.nvim_get_current_win()
    local toggleterm = require('toggleterm.terminal')

    for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      local win_type = vim.fn.win_gettype(win)
      if (win_type == '' or win_type == 'popup') and win ~= focused_win then
        local buf = vim.api.nvim_win_get_buf(win)

        if is_toggleterm_buffer(buf) then
          toggleterm.get(vim.b[buf].toggle_number).window = nil
        end

        if is_oil_buffer(buf) then
          local ok, original_buf = pcall(vim.api.nvim_win_get_var, win, 'oil_original_buffer')
          if ok and vim.api.nvim_buf_is_valid(original_buf) then
            vim.api.nvim_win_set_buf(win, original_buf)
          end
        end
      end
    end
  end,
  desc = 'Clear toggleterm window state before saving session',
})
-- }}}

-- {{{ Autocommand: Restore
vim.api.nvim_create_autocmd('User', {
  group = cmd_group,
  pattern = 'WindowRestoreEnd',
  callback = function(_)
    local focused_win = vim.api.nvim_get_current_win()
    local toggleterm = require('toggleterm.terminal')

    for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if win ~= focused_win then
        local buf = vim.api.nvim_win_get_buf(win)

        if is_toggleterm_buffer(buf) then
          toggleterm.get(vim.b[buf].toggle_number).window = win
        end
      end
    end
  end,
  desc = 'Update toggleterm window state after restoring session',
})
-- }}}

return {
  'declancm/maximize.nvim',
  -- "Kuwagata/maximize.nvim",
  dependencies = {
    'akinsho/toggleterm.nvim',
  },
  opts = {
    default_keymaps = false,
  },
  keys = {
    {
      '<leader>z',
      function()
        require('maximize').toggle()
      end,
      mode = { 'n' },
      desc = 'Maximize focused window',
    },
  },
}
