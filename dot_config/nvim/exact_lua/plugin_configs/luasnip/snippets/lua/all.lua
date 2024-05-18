s({ trig = "ymd", name = "Current date", dscr = "Insert the current date" }, {
	p(os.date, "%Y-%m-%d"),
})

s({ trig = "{,", wordTrig = false, hidden = true }, { t({ "{", "\t" }), i(1), t({ "", "}" }) })
