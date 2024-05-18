local shared = require("plugin_configs/nvim-dap/shared")

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("nvimdap_python", {}),
	pattern = "python",
	callback = function(_)
		local dap = require("dap")

		dap.adapters.debugpy = function(cb, config)
			if config.request == "attach" then
				---@diagnostic disable-next-line: undefined-field
				local port = (config.connect or config).port
				---@diagnostic disable-next-line: undefined-field
				local host = (config.connect or config).host or "127.0.0.1"
				cb({
					type = "server",
					port = assert(port, "`connect.port` is required for a python `attach` configuration"),
					host = host,
					options = {
						source_filetype = "python",
					},
				})
			else
				cb({
					type = "executable",
					command = "/usr/bin/python",
					args = { "-m", "debugpy.adapter" },
					options = {
						source_filetype = "python",
					},
				})
			end
		end

		dap.configurations.python = {
			{
				type = "debugpy",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = shared.getPythonPath,
				args = {},
			},
			{
				type = "debugpy",
				request = "launch",
				name = "Launch file with args",
				program = "${file}",
				pythonPath = shared.getPythonPath,
				args = shared.promptArgs,
			},
		}
	end,
})
