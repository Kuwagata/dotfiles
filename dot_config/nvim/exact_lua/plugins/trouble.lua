-- vim: set foldmethod=marker :
return {
	"folke/trouble.nvim",
	branch = "dev",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
	keys = {
		{ -- {{{ Toggle trouble UI
			"<leader>xx",
			function()
				require("trouble").toggle()
			end,
			desc = "Toggle",
		}, -- }}}
		{ -- {{{ Workspace diagnostics
			"<leader>xw",
			function()
				require("trouble").toggle("workspace_diagnostics")
			end,
			desc = "Workspace Diagnostics",
		}, -- }}}
		{ -- {{{ Document diagnostics
			"<leader>xd",
			function()
				require("trouble").toggle("document_diagnostics")
			end,
			desc = "Document Diagnostics",
		}, -- }}}
		{ -- {{{ Quickfix
			"<leader>xq",
			function()
				require("trouble").toggle("quickfix")
			end,
			desc = "Quickfix",
		}, -- }}}
		{ -- {{{ Loc list
			"<leader>xl",
			function()
				require("trouble").toggle("loclist")
			end,
			desc = "Loc list",
		}, -- }}}
		{ -- {{{ LSP references
			"<leader>xr",
			function()
				require("trouble").toggle("lsp_references")
			end,
			desc = "LSP References",
		}, -- }}}
	},
}
