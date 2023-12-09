return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		build = function()
			vim.cmd.helptags(vim.fn.stdpath("data") .. "/lazy/nvim-dap/doc")
		end,
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Continue (debug) ",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Step over (debug)",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Step into (debug)",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Step out (debug) ",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint()
				end,
				desc = "Set breakpoint",
			},
			{
				"<leader>dm",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "Set message breakpoint",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "Open REPL",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run last",
			},
			{
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Hover",
			},
			{
				"<leader>dp",
				function()
					require("dap.ui.widgets").preview()
				end,
				desc = "Preview",
			},
			{
				"<leader>df",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.frames)
				end,
				desc = "Frames",
			},
			{
				"<leader>ds",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.scopes)
				end,
				desc = "Scopes",
			},
		},
	},
}
