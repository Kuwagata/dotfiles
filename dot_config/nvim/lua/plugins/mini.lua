local sep = package.config:sub(1, 1)
local joinpath = function(directory, filename)
	return ("%s%s%s"):format(directory, sep, tostring(filename))
end

local module_error = function(module)
	return function(msg)
		error(("(%s) %s"):format(module, msg))
	end
end

return {
	{ "echasnovski/mini.cursorword", opts = {}, version = false },
	{ -- mini.hipatterns
		"echasnovski/mini.hipatterns",
		version = false,
		event = "VeryLazy",
		config = function()
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})
		end,
	},
	{ -- mini.sessions
		"echasnovski/mini.sessions",
		version = false,
		lazy = false,
		opts = {},
		keys = {
			{
				"<leader>msr",
				function()
					require("mini.sessions").select("read", {})
				end,
				desc = "Read",
			},
			{
				"<leader>msw",
				function()
					require("mini.sessions").select("write", {})
				end,
				desc = "Write",
			},
			{
				"<leader>msd",
				function()
					require("mini.sessions").select("delete", { force = true })
				end,
				desc = "Delete",
			},
			{
				"<leader>msn",
				function()
					local error = module_error("mini.sessions")
					local MiniSessions = require("mini.sessions")

					vim.ui.input({ prompt = "Enter name for new session" }, function(input)
						local session_name = tostring(input)
						if session_name == "" then
							error("Supply non-empty session name.")
						end

						local session_dir = (session_name == MiniSessions.config.file) and vim.fn.getcwd()
							or MiniSessions.config.directory
						local path = joinpath(session_dir, session_name)

						if vim.fn.isdirectory(path) == 1 then
							error(("Path '%s' is a directory"):format(path))
						elseif vim.fn.getfperm(path):sub(1, 1) == "r" then
							vim.ui.select({ "yes", "no" }, {
								prompt = ("Overwrite %s?"):format(path),
								telescope = require("telescope.themes").get_cursor(),
							}, function(selected)
								if selected == "yes" then
									MiniSessions.write(input, { force = true })
								end
							end)
						else
							MiniSessions.write(input, {})
						end
					end)
				end,
				desc = "New",
			},
		},
	},
	{ -- mini.splitjoin
		"echasnovski/mini.splitjoin",
		version = false,
		opts = { mappings = { toggle = "<leader>mt" } },
		keys = { { "<leader>mt", desc = "Toggle split/join" } },
	},
	{ -- mini.starter
		"echasnovski/mini.starter",
		version = false,
		opts = {},
	},
}
