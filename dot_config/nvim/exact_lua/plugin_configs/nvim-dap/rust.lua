local shared = require("plugin_configs/nvim-dap/shared")

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("nvimdap_rust", {}),
	pattern = "rust",
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

		local function initCommands()
			local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

			local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
			local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

			local commands = {}
			local file = io.open(commands_file, "r")
			if file then
				for line in file:lines() do
					table.insert(commands, line)
				end
				file:close()
			end
			table.insert(commands, 1, script_import)

			return commands
		end

		dap.configurations.rust = {
			{
				name = "Launch GDB",
				type = "gdb",
				request = "launch",
				program = shared.getExePath,
				cwd = "${workspaceFolder}",
				initCommands = initCommands,
				args = {},
			},
			{
				name = "Launch GDB with args",
				type = "gdb",
				request = "launch",
				program = shared.getExePath,
				cwd = "${workspaceFolder}",
				initCommands = initCommands,
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
				initCommands = initCommands,
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
				initCommands = initCommands,
			},
			{
				name = "Attach GDB",
				type = "gdb",
				request = "attach",
				initCommands = initCommands,
				pid = require("dap.utils").pick_process,
				args = {},
			},
			{
				name = "Attach LLDB",
				type = "lldb",
				request = "attach",
				initCommands = initCommands,
				pid = require("dap.utils").pick_process,
				args = {},
			},
		}
	end,
})
