-- vim: set foldmethod=marker :
return {
	"b0o/incline.nvim",
	--enabled = false, -- Dropbar now takes care of this with breadcrumbs
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		window = {
			padding = 0,
			margin = { horizontal = 0 },
			overlap = {
				borders = true,
				statusline = false,
				tabline = false,
				winbar = true,
			},
		},
		render = function(props)
			local helpers = require("incline.helpers")
			local devicons = require("nvim-web-devicons")
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
			if filename == "" then
				filename = "[No Name]"
			end
			local ft_icon, ft_color = devicons.get_icon_color(filename)
			local modified = vim.bo[props.buf].modified
			return {
				ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
				" ",
				{ filename, gui = modified and "bold,italic" or "bold" },
				" ",
				guibg = "#44406e",
			}
		end,
	},
	event = "VeryLazy",
}
