local vvar = vim.api.nvim_get_vvar
return {
	{
		"numToStr/Comment.nvim",
		opts = { mappings = false },
		keys = {
			{
				"<leader>cc",
				function()
					return vvar("count") == 0 and "<Plug>(comment_toggle_linewise_current)"
						or "<Plug>(comment_toggle_linewise_count)"
				end,
				desc = "Toggle linewise",
				expr = true,
			},
			{
				"<leader>cb",
				function()
					return vvar("count") == 0 and "<Plug>(comment_toggle_blockwise_current)"
						or "<Plug>(comment_toggle_blockwise_count)"
				end,
				desc = "Toggle blockwise",
				expr = true,
			},
			{ "<leader>cc", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle linewise", mode = "x" },
			{ "<leader>cb", "<Plug>(comment_toggle_blockwise_visual)", desc = "Toggle blockwise", mode = "x" },
		},
	},
}
