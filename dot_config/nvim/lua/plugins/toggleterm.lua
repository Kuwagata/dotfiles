return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		dependencies = {
			"stevearc/dressing.nvim", -- For fancy UIs and custom commands
		},
		opts = {},
		keys = {
			{
				[[<c-\>l]],
				":TermSelect<CR>",
				desc = "Terminal list",
				silent = true,
				mode = { "n", "i", "v" },
			},
			{
				[[<c-\>r]],
				":ToggleTermSetName<CR>",
				desc = "Set terminal name",
				silent = true,
				mode = { "n", "i", "v" },
			},
			{
				[[<c-\>a]],
				":ToggleTermToggleAll<CR>",
				desc = "Toggle all",
				silent = true,
				mode = { "n", "i", "v" },
			},
			{
				[[<c-\>s]],
				":ToggleTerm direction=horizontal<CR>",
				desc = "Toggle horizontal terminal",
				silent = true,
				mode = { "n", "i", "v" },
			},
			{
				[[<c-\>v]],
				":ToggleTerm direction=vertical<CR>",
				desc = "Toggle vertical terminal",
				silent = true,
				mode = { "n", "i", "v" },
			},
			{
				[[<c-\>f]],
				":ToggleTerm direction=floating<CR>",
				desc = "Toggle floating terminal",
				silent = true,
				mode = { "n", "i", "v" },
			},
			{
				[[<c-\>t]],
				":ToggleTerm direction=tab<CR>",
				desc = "Toggle tabbed terminal",
				silent = true,
				mode = { "n", "i", "v" },
			},
			{
				[[<c-\>n]],
				function()
					vim.ui.select({
						"horizontal",
						"vertical",
						"float",
						"tab",
					}, {
						prompt = "Select layout",
						telescope = require("telescope.themes").get_cursor(),
					}, function(selected, idx)
						if idx ~= nil then
							require("toggleterm.terminal").Terminal:new({ direction = selected }):toggle()
						end
					end)
				end,
				desc = "New terminal",
				silent = true,
				mode = { "n", "i", "v" },
				expr = true,
			},
		},
	},
}
