-- vim: set foldmethod=marker :
return {
	"nvim-treesitter/nvim-treesitter",
	name = "nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = { -- {{{ List of languages
			"bash",
			"c",
			"cmake",
			"cpp",
			"css",
			"diff",
			"git_rebase",
			"gitattributes",
			"gitignore",
			"go",
			"html",
			"java",
			"javascript",
			"json",
			"latex",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"python",
			"racket",
			"rust",
			"scheme",
			"toml",
			"typescript",
			"yaml",
		}, -- }}}
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	end,
}
