return {
	{
		"nvim-lualine/lualine.nvim",
		name = "lualine",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			options = {
				theme = "catppuccin",
			},
			extensions = {
				"lazy",
				"man",
				"toggleterm",
				"trouble",
			},
		},
	},
}
