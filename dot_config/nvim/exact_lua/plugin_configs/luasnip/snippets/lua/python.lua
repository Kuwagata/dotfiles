local function process_args(raw_args)
	local args = {}

	if #raw_args > 0 then
		for _, line in pairs(raw_args[1]) do
			for _, arg in pairs(vim.split(line, ",")) do
				table.insert(args, vim.trim(vim.split(arg, "=")[1]))
			end
		end
	end

	if #args > 0 and args[1] == "self" then
		table.remove(args, 1)
	end

	return args
end

local function document_function(raw_args, _, _, indent)
	local nodes = {
		i(1, {
			"Summary line.",
			"",
			"Long description.",
		}),
	}

	local args = process_args(raw_args)
	if #args > 0 then
		table.insert(nodes, t({ "", "", "Args:" }))
		for idx, arg in pairs(args) do
			table.insert(nodes, t({ "", arg .. ": " }))
			table.insert(nodes, i(idx + 1, "Description For " .. arg))
		end
	end

	return isn(nil, nodes, "$PARENT_INDENT" .. indent)
end

s(
	{
		trig = "cls",
		name = "Python Class",
		desc = "Documented python class",
	},
	fmt(
		[[
        class {class_definition}:
            """
            {class_docstring}
            """

            def init({init_args}):
                """
                {init_docstring}
                """
                {self_assignments}
        ]],
		{
			class_definition = i(1, "class_name"),
			class_docstring = isn(2, {
				i(1, {
					"Summary line.",
					"",
					"Long description.",
				}),
			}, "$PARENT_INDENT\t"),
			init_args = i(3, "self", { key = "init_args" }),
			init_docstring = d(4, document_function, { k("init_args") }, { user_args = { "\t\t" } }),
			self_assignments = d(5, function(raw_args)
				local nodes = {}

				local args = process_args(raw_args)
				if #args > 0 then
					for _, arg in pairs(args) do
						table.insert(nodes, t({ "self." .. arg .. " = " .. arg, "" }))
					end
				end

				return isn(nil, nodes, "$PARENT_INDENT\t\t")
			end, { k("init_args") }),
		}
	)
)

s(
	{
		trig = "fn",
		name = "Python Function",
		dscr = "Documented python function",
	},
	fmt(
		[[
        def {function_name}({args}):
            """{docstring}"""
            {body}
        ]],
		{
			function_name = i(1, "function_name"),
			args = i(2, "args", { key = "init_args" }),
			docstring = c(3, {
				sn(nil, {
					t({ "", "\t" }),
					d(1, document_function, { k("init_args") }, { user_args = { "\t" } }),
					t({ "", "\t" }),
				}),
				sn(nil, { i(1, "One line description.") }),
			}),
			body = i(0),
		}
	)
)
