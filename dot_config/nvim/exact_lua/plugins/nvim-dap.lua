-- vim: set foldmethod=marker :
return {
	{ -- {{{ nvim-dap
		"mfussenegger/nvim-dap",
		lazy = true,
		build = function()
			vim.cmd.helptags(vim.fn.stdpath("data") .. "/lazy/nvim-dap/doc")
		end,
		config = function()
			require("dapui")
		end,
		keys = {
			{ -- {{{ Continue
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Continue (debug) ",
			}, -- }}}
			{ -- {{{ Step over
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Step over (debug)",
			}, -- }}}
			{ -- {{{ Step into
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Step into (debug)",
			}, -- }}}
			{ -- {{{ Step out
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Step out (debug) ",
			}, -- }}}
			{ -- {{{ Toggle breakpoint
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			}, -- }}}
			{ -- {{{ Set breakpoint
				"<leader>dB",
				function()
					require("dap").set_breakpoint()
				end,
				desc = "Set breakpoint",
			}, -- }}}
			{ -- {{{ Set message breakpoint
				"<leader>dm",
				function()
					require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
				end,
				desc = "Set message breakpoint",
			}, -- }}}
			{ -- {{{ Open REPL
				"<leader>dr",
				function()
					require("dap").repl.open()
				end,
				desc = "Open REPL",
			}, -- }}}
			{ -- {{{ Run last
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run last",
			}, -- }}}
			{ -- {{{ Hover
				"<leader>dh",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Hover",
			}, -- }}}
			{ -- {{{ Preview
				"<leader>dp",
				function()
					require("dap.ui.widgets").preview()
				end,
				desc = "Preview",
			}, -- }}}
			{ -- {{{ Frames
				"<leader>df",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.frames)
				end,
				desc = "Frames",
			}, -- }}}
			{ -- {{{ Scopes
				"<leader>ds",
				function()
					local widgets = require("dap.ui.widgets")
					widgets.centered_float(widgets.scopes)
				end,
				desc = "Scopes",
			}, -- }}}
		},
	}, -- }}}
	{ -- {{{ nvim-dap-ui
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		lazy = true,
		opts = {},
		config = function(_, opts)
			local dap, dapui = require("dap"), require("dapui")

			dapui.setup(opts)

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end

			-- dap.listeners.before.event_terminated["dapui_config"] = function()
			-- 	dapui.close()
			-- end
			--
			-- dap.listeners.before.event_exited["dapui_config"] = function()
			-- 	dapui.close()
			-- end
		end,
		keys = {
			{ -- {{{ Toggle UI
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle UI",
			}, -- }}}
		},
	}, -- }}}
}
