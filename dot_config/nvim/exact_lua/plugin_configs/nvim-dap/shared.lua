local M = {}

function M.getExePath()
	return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

function M.inheritEnv()
	local variables = {}
	for k, v in pairs(vim.fn.environ()) do
		table.insert(variables, string.format("%s=%s", k, v))
	end
	return variables
end

function M.promptArgs()
	local args_string = vim.fn.input("Arguments: ")
	return vim.split(args_string, " +")
end

function M.getPythonPath()
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
end

return M
