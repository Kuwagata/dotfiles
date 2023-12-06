vim.api.nvim_create_autocmd("WinEnter", {
	group = vim.api.nvim_create_augroup("FocusDisable", {}),
	callback = function(_)
		if vim.tbl_contains({ "nofile", "prompt", "popup" }, vim.bo.buftype) then
			vim.w.focus_disable = true
		else
			vim.w.focus_disable = false
		end
	end,
	desc = "Disable focus autoresize for BufType",
})
