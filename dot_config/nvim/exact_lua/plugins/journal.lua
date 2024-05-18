-- vim: set foldmethod=marker :
return {
	"jakobkhansen/journal.nvim",
	event = "VeryLazy",
	opts = {
		filetype = "md",
		root = "~/journal",
		date_format = "%d/%m/%Y",
		-- journal = {},
	},
	-- keys = {},
}
