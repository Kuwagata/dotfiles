local function dynamic_if(_, snip)
	if not snip.elseif_count then
		snip.elseif_count = 0
	end

	local nodes = {}

	table.insert(nodes, t({ "if " }))
	table.insert(nodes, r(1, "conditional_1", i(nil, [[true]])))
	table.insert(nodes, t({ " then", "\t" }))
	table.insert(nodes, r(2, "consequent_1", i(nil, [[-- Consequent]])))
	table.insert(nodes, t({ "", "" }))

	local input_idx = 3
	for elseif_idx = 1, snip.elseif_count do
		table.insert(nodes, t({ "elseif " }))
		table.insert(nodes, r(input_idx, "elseif_conditional_" .. tostring(elseif_idx), i(nil, [[true]])))
		table.insert(nodes, t({ " then", "\t" }))
		table.insert(nodes, r(input_idx + 1, "elseif_consequent_" .. tostring(elseif_idx), i(nil, [[-- Consequent]])))
		table.insert(nodes, t({ "", "" }))
		input_idx = input_idx + 2
	end

	if snip.toggle_else then
		table.insert(nodes, t({ "else", "\t" }))
		table.insert(nodes, r(input_idx, "consequent_else", i(nil, [[-- Consequent]])))
		table.insert(nodes, t({ "", "" }))
	end

	table.insert(nodes, t({ "end" }))

	return sn(nil, nodes)
end

local if_funcs = {
	["grow"] = function(snip)
		snip.elseif_count = snip.elseif_count + 1
	end,
	["shrink"] = function(snip)
		snip.elseif_count = math.max(snip.elseif_count - 1, 0)
	end,
	["toggle"] = function(snip)
		snip.toggle_else = not snip.toggle_else
	end,
}

-- If-Else
s({
	trig = "if",
	name = "Lua if-else",
	dscr = "Lua if-statement with optional else.",
}, {
	c(1, {
		d(nil, dynamic_if, {}, {
			user_args = { ["dynamic_funcs"] = if_funcs },
		}),
		sn(
			nil,
			fmt([[if {} then {} end]], {
				r(1, "condition", i(nil, [[true]])),
				c(2, {
					r(nil, "consequent", i(nil, [[print("if true")]])),
					sn(
						nil,
						fmt([[{} else {}]], {
							r(1, "consequent", i(nil, [[print("if true")]])),
							r(2, "alternative", i(nil, [[print("if false")]])),
						})
					),
				}),
			})
		),
	}),
})
