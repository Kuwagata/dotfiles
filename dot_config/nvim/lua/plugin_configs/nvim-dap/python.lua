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
				pythonPath = function()
					local venv = os.getenv("VIRTUAL_ENV")
					local cwd = vim.fn.getcwd()
					if venv then
						return venv .. "/bin/python"
					elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
						return cwd .. "/venv/bin/python"
					elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
						return cwd .. "/.venv/bin/python"
					else
						return "/usr/bin/python"
					end
				end,
			},
		}
	end,
})
