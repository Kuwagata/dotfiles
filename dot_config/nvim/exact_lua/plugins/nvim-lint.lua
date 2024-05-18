-- vim: set foldmethod=marker :
return {
	"mfussenegger/nvim-lint",
	opts = {
		bash = { "shellcheck" },
		c = { "clangtidy", "cpplint", "cppcheck" },
		cpp = { "clangtidy", "cpplint", "cppcheck" },
		go = { "golangcilint" },
		html = { "tidy" },
		javascript = { "eslint_d" },
		latex = { "chktex" },
		lua = { "luacheck" },
		python = { "ruff", "bandit" },
		sh = { "shellcheck" },
		zsh = { "zsh" },
	},
	config = function(_, opts)
		require("lint").linters_by_ft = opts

		vim.api.nvim_create_autocmd({ "BufWinEnter", "BufWritePost" }, {
			group = vim.api.nvim_create_augroup("linting", {}),
			callback = function(_)
				require("lint").try_lint()
			end,
		})
	end,
}
