return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon"):list():append()
				end,
				desc = "Add to harpoon",
			},
			{
				"<C-e>",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon list",
			},
		},
	},
}
