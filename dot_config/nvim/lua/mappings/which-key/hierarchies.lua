-- These are only ever needed in the context of which-key for labeling key hierarchies
require("which-key").register({
	c = { name = "Comment" },
	d = { name = "Debug" },
	f = { name = "Find" },
	g = { name = "Go" },
	m = {
		name = "Mini",
		s = { name = "Sessions" },
	},
	r = {
		name = "Refactoring",
		e = { name = "Extract" },
		i = { name = "Inline" },
		p = { name = "Print" },
	},
	x = { name = "Trouble" },
}, { prefix = "<leader>" })
