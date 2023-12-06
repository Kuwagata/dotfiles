return {
	{
		"nvim-focus/focus.nvim",
		version = false,
		opts = {
			commands = true,
			autoresize = {
				enable = true,
			},
			split = {
				bufnew = false,
			},
			ui = {
				number = false,
				relativenumber = false,
				hybridnumber = false,
				absolutenumber_unfocussed = false,
				cursorline = true,
				cursorcolumn = false,
				colorcolumn = {
					enable = false,
					list = "+1",
				},
				signcolumn = true,
				winhighlight = false,
			},
		},
		keys = {
			{
				"<leader>n",
				function()
					local ignore_buftypes = { "nofile", "prompt", "popup", "terminal" }
					if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
						print(("Cannot split in %s"):format(vim.bo.buftype))
					else
						require("focus").split_nicely()
					end
				end,
				desc = "Split nicely",
			},
		},
	},
}
