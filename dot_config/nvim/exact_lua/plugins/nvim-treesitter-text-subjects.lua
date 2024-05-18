-- vim: set foldmethod=marker :
return {
	"RRethy/nvim-treesitter-textsubjects",
	opts = {
		textsubjects = {
			enable = true,
			prev_selection = ",", -- (Optional) keymap to select the previous selection
			keymaps = {
				["."] = { "textsubjects-smart", desc = "Smart container select" },
				[";"] = {
					"textsubjects-container-outer",
					desc = "Select outside containers (classes, functions, etc.)",
				},
				["i;"] = {
					"textsubjects-container-inner",
					desc = "Select inside containers (classes, functions, etc.)",
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
