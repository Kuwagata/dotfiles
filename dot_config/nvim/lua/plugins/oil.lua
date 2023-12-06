return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
		},
		keys = {
			{
				"-",
				function()
					require("oil").open()
				end,
				desc = "Open parent directory",
			},
			{
				"_",
				function()
					require("oil").toggle_float()
				end,
				desc = "Open parent directory",
			},
		},
	},
}
