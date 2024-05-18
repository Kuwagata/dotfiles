-- For loop
s(
	{
		trig = "for",
		name = "Lua For Loop",
		dscr = "Lua for loop.",
	},
	fmt(
		[[
        for {loop_declaration} do
            {loop_contents}
        end
        ]],
		{
			loop_declaration = c(1, {
				sn(
					nil,
					fmt([[{}={},{}]], {
						r(1, "loop_var"),
						r(2, "initial_value"),
						r(3, "end_value"),
					})
				),
				sn(
					nil,
					fmt([[{}={},{},{}]], {
						r(1, "loop_var"),
						r(2, "initial_value"),
						r(3, "end_value"),
						r(4, "step"),
					})
				),
			}),
			loop_contents = i(2, "-- loop contents"),
		}
	),
	{
		stored = {
			["loop_var"] = i(1, "var"),
			["initial_value"] = i(2, "1"),
			["end_value"] = i(3, "3"),
			["step"] = i(4, "1"),
		},
	}
)

-- For-each loop (array table)
s(
	{
		trig = "foreach",
		name = "Lua For-Each Array Loop",
		dscr = "Loops over the values in an array.",
	},
	fmt(
		[[
        for {index}, {value} in ipairs({array}) do
            {loop_contents}
        end
        ]],
		{
			index = i(1, "idx"),
			value = i(2, "val"),
			array = i(3, "{}"),
			loop_contents = i(4, "-- loop contents"),
		}
	)
)

-- For-each loop (dictionary table)
s(
	{
		trig = "foreachkv",
		name = "Lua For-Each Dictionary Loop",
		dscr = "Loops over the values in an key-value table.",
	},
	fmt(
		[[
        for {key}, {value} in pairs({array}) do
            {loop_contents}
        end
        ]],
		{
			key = i(1, "key"),
			value = i(2, "val"),
			array = i(3, "{}"),
			loop_contents = i(4, "-- loop contents"),
		}
	)
)

-- While loop
s(
	{
		trig = "while",
		name = "Lua While Loop",
		dscr = "Lua while loop.",
	},
	fmt(
		[[
        while {condition} do
            {loop_contents}
        end
        ]],
		{
			condition = i(1, "true"),
			loop_contents = i(2, "-- loop contents"),
		}
	)
)

-- Repeat until loop (do-while)
s(
	{
		trig = "repeat",
		name = "Lua Repeat Loop",
		dscr = "Lua repeat loop.",
	},
	fmt(
		[[
        repeat
            {loop_contents}
        until {condition}
        ]],
		{
			loop_contents = i(1, "-- loop contents"),
			condition = i(2, "true"),
		}
	)
)
