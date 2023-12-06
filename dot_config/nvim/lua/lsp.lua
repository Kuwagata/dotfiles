vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client.server_capabilities.completionProvider then
			vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		end

		if client.server_capabilities.definitionProvider then
			vim.bo[args.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
		end
	end,
})
