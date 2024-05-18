-- vim: set foldmethod=marker :
return {
	"nvim-lualine/lualine.nvim",
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
			"nvim-dap-ui",
			"oil",
			"toggleterm",
			"trouble",
		},
	},
}
