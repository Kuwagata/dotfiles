-- Snippet: s()
s(
	{
		trig = "snip",
		name = "Luasnip Snippet",
		dscr = "Creates an empty Luasnip snippet.",
	},
	fmt(
		[[
        s(
            {{
                trig = "{trigger}",
                name = "{name}",
                dscr = "{description}",
            }},
            {nodes}
        )
        ]],
		{
			trigger = i(1, "trigger"),
			name = i(2, "name"),
			description = i(3, "description"),
			nodes = i(4, [[{"list", "of", "nodes"}]]),
		}
	)
)
-- Format nodes: fmt()
s(
	{
		trig = "fmt",
		name = "Luasnip Fmt Block",
		dscr = "Sets up a general multi-line luasnip format node.",
	},
	fmt(
		[=[
        fmt(
            [[
            {fmt_string}
            ]],
            {{
                {fmt_values}
            }}
        )
        ]=],
		{
			fmt_string = i(1, "{format_string}"),
			fmt_values = i(2, 'format_string = i(1, "an example"),'),
		}
	)
)
