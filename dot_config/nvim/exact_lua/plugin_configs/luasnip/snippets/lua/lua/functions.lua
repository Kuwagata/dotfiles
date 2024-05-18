s(
	{
		trig = "fn",
		name = "Lua Function",
		dscr = "Lua function.",
	},
	fmt(
		[[
        {declaration} {name}({args})
            {body}
        end
        ]],
		{
			declaration = c(1, { t("local function"), t("function") }),
			name = i(2, "function_name"),
			args = i(3, "args"),
			body = i(4, "-- body"),
		}
	)
)
