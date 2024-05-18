local present, catppuccin = pcall(require, "catppuccin")
if not present then
	return
end

catppuccin.setup({
	flavour = "mocha", -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = "latte",
		dark = "mocha",
	},
	compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
	term_colors = false,
	dim_inactive = {
		enabled = true,
		--shade = "dark",
		--percentage = 0.5,
	},
	integrations = {
		gitsigns = true,
		indent_blankline = {
			enabled = true,
			--scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
			colored_indent_levels = true,
		},
		lsp_trouble = true,
		native_lsp = {
			enabled = true,
		},
		telescope = true,
		treesitter = true,
		which_key = true,
	},
})
vim.cmd.colorscheme("catppuccin")
