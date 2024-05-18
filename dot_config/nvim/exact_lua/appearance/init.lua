require("appearance/catppuccin")

-- Add borders to lsp popups and completion popups
local border_style = "rounded"
local handlers = vim.lsp.handlers
handlers["textDocument/hover"] = vim.lsp.with(handlers.hover, { border = border_style })
handlers["textDocument/signatureHelp"] = vim.lsp.with(handlers.signature_help, { border = border_style })
vim.g.completion_popup_border = border_style

-- Dim when focus switches
local focus = vim.api.nvim_create_augroup("FocusDimming", {})
vim.api.nvim_create_autocmd("FocusLost", {
	group = focus,
	callback = function(_)
		vim.api.nvim_set_hl(0, "Normal", vim.api.nvim_get_hl(0, { name = "NormalNC" }))
	end,
})
vim.api.nvim_create_autocmd("FocusGained", {
	group = focus,
	callback = function(_)
		vim.api.nvim_set_hl(0, "Normal", vim.api.nvim_get_hl(0, { name = "Normal" }))
	end,
})
