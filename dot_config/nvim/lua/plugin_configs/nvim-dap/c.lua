vim.api.nvim_create_autocmd("FileType", {
	pattern = "c",
	callback = function(_)
		local dap = require("dap")

		if dap.adapters.gdb == nil then
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "-i", "dap" },
			}
		end

		if dap.adapters.lldb == nil then
			dap.adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-vscode",
				name = "lldb",
			}
		end

		if dap.configurations.c == nil then
			dap.configurations.c = {
				{
					name = "Launch GDB",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
				},
				{
					name = "Launch LLDB",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}
		end
	end,
})
