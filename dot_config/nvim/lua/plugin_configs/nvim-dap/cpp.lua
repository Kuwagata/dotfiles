local shared = require("plugin_configs/nvim-dap/shared")

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("nvimdap_cpp", {}),
	pattern = "cpp",
	callback = function(_)
		local dap = require("dap")

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}

		dap.adapters.lldb = {
			type = "executable",
			command = "/usr/bin/lldb-vscode",
			name = "lldb",
		}

		dap.configurations.cpp = {
			{
				name = "Launch GDB",
				type = "gdb",
				request = "launch",
				program = shared.getExePath,
				cwd = "${workspaceFolder}",
				args = {},
			},
			{
				name = "Launch GDB with args",
				type = "gdb",
				request = "launch",
				program = shared.getExePath,
				cwd = "${workspaceFolder}",
				args = shared.promptArgs,
			},
			{
				name = "Launch LLDB",
				type = "lldb",
				request = "launch",
				program = shared.getExePath,
				cwd = "${workspaceFolder}",
				env = shared.inheritEnv,
				stopOnEntry = false,
				args = {},
			},
			{
				name = "Launch LLDB with args",
				type = "lldb",
				request = "launch",
				program = shared.getExePath,
				cwd = "${workspaceFolder}",
				env = shared.inheritEnv,
				stopOnEntry = false,
				args = shared.promptArgs,
			},
			{
				name = "Attach GDB",
				type = "gdb",
				request = "attach",
				pid = require("dap.utils").pick_process,
				args = {},
			},
			{
				name = "Attach LLDB",
				type = "lldb",
				request = "attach",
				pid = require("dap.utils").pick_process,
				args = {},
			},
		}
	end,
})
