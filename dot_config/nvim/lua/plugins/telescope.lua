local function close(...)
	require("telescope.actions").close(...)
end

local function open_with_trouble(...)
	require("trouble.providers.telescope").open_with_trouble(...)
end

return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
		end,
		opts = {
			defaults = {
				mappings = {
					n = {
						["q"] = close,
						["<c-t>"] = open_with_trouble,
					},
					i = {
						["<c-t>"] = open_with_trouble,
					},
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				frecency = {
					workspaces = {
						["projects"] = "/home/john/Projects",
						["documents"] = "/home/john/Documents",
					},
				},
				file_browser = {},
			},
		},
		keys = {
			-- Defined in mappings/which-key.lua for when LSP loads
			"<leader>lfd",
			"<leader>lfw",
			"<leader>lfW",
			"<leader>lfr",
			"<leader>lfi",
			"<leader>lfo",
			{
				"<leader>b",
				function()
					return require("telescope.builtin").buffers({
						ignore_current_buffer = true,
						sort_mru = true,
					})
				end,
				desc = "Buffers",
			},
			{
				"<leader>ff",
				function()
					return require("telescope.builtin").find_files()
				end,
				desc = "Files",
			},
			{
				"<leader>fs",
				function()
					return require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
				end,
				desc = "Sibling files",
			},
			{
				"<leader>fb",
				function()
					return require("telescope.builtin").buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fg",
				function()
					return require("telescope.builtin").live_grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>fd",
				function()
					return require("telescope.builtin").diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>ft",
				function()
					return require("telescope.builtin").treesitter()
				end,
				desc = "Treesitter",
			},
			{
				"<leader>h",
				function()
					return require("telescope.builtin").help_tags()
				end,
				desc = "Help",
			},
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("telescope").load_extension("frecency")
		end,
		keys = {
			{
				"<leader>fr",
				function()
					return require("frecency").start()
				end,
				desc = "Telescope frecency",
			},
		},
	},
}
