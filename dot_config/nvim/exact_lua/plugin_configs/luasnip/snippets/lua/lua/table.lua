local function list_items(_, snip)
	if not snip.elements then
		snip.elements = 1
	end

	local nodes = {}

	table.insert(nodes, t({ "{" }))
	if snip.single_line then
		table.insert(nodes, t({ " " }))
		for idx = 1, snip.elements do
			table.insert(nodes, t({ "" }))
			table.insert(nodes, r(idx, tostring(idx), i(nil, [["value"]])))
			table.insert(nodes, t({ ", " }))
		end
		nodes[#nodes] = t({ "" })
		table.insert(nodes, t({ " " }))
	else
		table.insert(nodes, t({ "", "" }))
		for idx = 1, snip.elements do
			table.insert(nodes, t({ "\t" }))
			table.insert(nodes, r(idx, tostring(idx), i(nil, [["value"]])))
			table.insert(nodes, t({ ",", "" }))
		end
		nodes[#nodes] = t({ "" })
		table.insert(nodes, t({ "", "" }))
	end
	table.insert(nodes, t({ "}" }))
	return sn(nil, nodes)
end

local function kv_items(_, snip)
	if not snip.elements then
		snip.elements = 1
	end

	local nodes = {}

	table.insert(nodes, t({ "{" }))
	if snip.single_line then
		table.insert(nodes, t({ " " }))
		for idx = 1, (snip.elements * 2), 2 do
			table.insert(nodes, t({ "" }))
			table.insert(nodes, r(idx, tostring(idx), i(nil, [[key]])))
			table.insert(nodes, t({ " = " }))
			table.insert(nodes, r(idx + 1, tostring(idx + 1), i(nil, [["value"]])))
			table.insert(nodes, t({ ", " }))
		end
		nodes[#nodes] = t({ "" })
		table.insert(nodes, t({ " " }))
	else
		table.insert(nodes, t({ "", "" }))
		for idx = 1, (snip.elements * 2), 2 do
			table.insert(nodes, t({ "\t" }))
			table.insert(nodes, r(idx, tostring(idx), i(nil, [[key]])))
			table.insert(nodes, t({ " = " }))
			table.insert(nodes, r(idx + 1, tostring(idx + 1), i(nil, [["value"]])))
			table.insert(nodes, t({ ",", "" }))
		end
		nodes[#nodes] = t({ "" })
		table.insert(nodes, t({ "", "" }))
	end
	table.insert(nodes, t({ "}" }))
	return sn(nil, nodes)
end

local list_funcs = {
	["grow"] = function(snip)
		snip.elements = snip.elements + 1
	end,
	["shrink"] = function(snip)
		snip.elements = math.max(snip.elements - 1, 1)
	end,
	["toggle"] = function(snip)
		snip.single_line = not snip.single_line
	end,
}

s({
	trig = "tab",
	name = "Lua Table",
	dscr = "Dynamic lua table",
}, {
	d(1, list_items, {}, {
		user_args = { ["dynamic_funcs"] = list_funcs },
	}),
})

s({
	trig = "kvtab",
	name = "Lua Key-Value Table",
	dscr = "Dynamic lua key-value table",
}, {
	d(1, kv_items, {}, {
		user_args = { ["dynamic_funcs"] = list_funcs },
	}),
})
