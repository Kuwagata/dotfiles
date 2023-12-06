local lua_opts = {
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
				},
			})
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
}

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local nvim_lsp = require("lspconfig")
			nvim_lsp.clangd.setup({})
			nvim_lsp.cmake.setup({})
			nvim_lsp.pyright.setup({})
			nvim_lsp.rust_analyzer.setup({})
			nvim_lsp.lua_ls.setup(lua_opts)
		end,
	},
}
