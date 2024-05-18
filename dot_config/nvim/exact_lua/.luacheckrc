stds.luacheck = {
	globals = {
		"stds",
		"std",
	},
}

stds.nvim = {
	globals = {
		"vim",
	},
}

stds.luasnip = {
	globals = {
		"s",
		"sn",
		"isn",
		"t",
		"i",
		"f",
		"c",
		"d",
		"r",
		"events",
		"ai",
		"extras",
		"l",
		"rep",
		"p",
		"m",
		"n",
		"dl",
		"fmt",
		"fmta",
		"conds",
		"postfix",
		"types",
		"parse",
		"ms",
		"k",
	},
}

std = "max+luacheck+nvim+luasnip"
