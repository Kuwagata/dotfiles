-- vim: set foldmethod=marker :
return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {},
	config = function(_, opts)
		require("refactoring").setup(opts)
	end,
	keys = {
		{ -- {{{ Extract function
			"<leader>ref",
			function()
				require("refactoring").refactor("Extract Function")
			end,
			desc = "Extract function",
			silent = true,
			mode = { "x" },
		}, -- }}}
		{ -- {{{ Extract function to file
			"<leader>reF",
			function()
				require("refactoring").refactor("Extract Function To File")
			end,
			desc = "Extract function to file",
			silent = true,
			mode = { "x" },
		}, -- }}}
		{ -- {{{ Extract variable
			"<leader>rev",
			function()
				require("refactoring").refactor("Extract Variable")
			end,
			desc = "Extract variable",
			silent = true,
			mode = { "x" },
		}, -- }}}
		{ -- {{{ Inline function
			"<leader>rif",
			function()
				require("refactoring").refactor("Inline Function")
			end,
			desc = "Inline function",
			silent = true,
		}, -- }}}
		{ -- {{{ Inline variable
			"<leader>riv",
			function()
				require("refactoring").refactor("Inline Variable")
			end,
			desc = "Inline variable",
			silent = true,
			mode = { "n", "x" },
		}, -- }}}
		{ -- {{{ Extract block
			"<leader>reb",
			function()
				require("refactoring").refactor("Extract Block")
			end,
			desc = "Extract block",
			silent = true,
		}, -- }}}
		{ -- {{{ Extract block to file
			"<leader>reB",
			function()
				require("refactoring").refactor("Extract Block To File")
			end,
			desc = "Extract block to file",
			silent = true,
		}, -- }}}
		{ -- {{{ Refactor menu
			"<leader>rr",
			function()
				require("refactoring").select_refactor()
			end,
			desc = "Refactor menu",
			silent = true,
			mode = { "n", "x" },
		}, -- }}}
		{ -- {{{ Add printf
			"<leader>rpf",
			function()
				require("refactoring").debug.printf({ below = false })
			end,
			desc = "Add printf",
			silent = true,
		}, -- }}}
		{ -- {{{ Print variable
			"<leader>rpv",
			function()
				require("refactoring").debug.print_var()
			end,
			desc = "Print variable",
			silent = true,
			mode = { "n", "v" },
		}, -- }}}
		{ -- {{{ Cleanup
			"<leader>rpc",
			function()
				require("refactoring").debug.cleanup({})
			end,
			desc = "Cleanup",
			silent = true,
		}, -- }}}
	},
}
