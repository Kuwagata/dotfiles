-- Requires neovim 0.10
--[[ return {
	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
            "nvim-tree/nvim-web-devicons",
		},
		opts = {},
        keys = {
            -- Interactive picker:  require('dropbar.api').pick()
            -- Fuzzy finder:        dropbar_menu_t:fuzzy_find_open()
        },
	},
} ]]
return {}
