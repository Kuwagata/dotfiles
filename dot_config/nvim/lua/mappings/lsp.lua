vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspMappings", {}),
	callback = function(args)
		local format_func = function()
			vim.lsp.buf.format({ async = true })
		end

		local list_workspaces_func = function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end

		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local mappings = {
			["<leader>lD"] = { func = vim.lsp.buf.declaration, desc = "Go to declaration" },
			["<leader>ld"] = { func = vim.lsp.buf.definition, desc = "Go to definition" },
			["<leader>li"] = { func = vim.lsp.buf.implementation, desc = "Go to implementation" },
			["<leader>lr"] = { func = vim.lsp.buf.references, desc = "Go to references" },
			["<leader>lK"] = { func = vim.lsp.buf.hover, desc = "Hover menu" },
			["<leader>ls"] = { func = vim.lsp.buf.signature_help, desc = "Signature help" },
			["<leader>lR"] = { func = vim.lsp.buf.rename, desc = "Rename" },
			["<leader>lt"] = { func = vim.lsp.buf.type_definition, desc = "Type definition" },
			["<leader>lc"] = { func = vim.lsp.buf.code_action, desc = "Code action" },
			["<leader>lf"] = { func = format_func, desc = "Format" },
			["<leader>lwa"] = { func = vim.lsp.buf.add_workspace_folder, desc = "Add workspace folder" },
			["<leader>lwr"] = { func = vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder" },
			["<leader>lwl"] = { func = list_workspaces_func, desc = "List workspace folders" },
		}
		for keys, details in pairs(mappings) do
			vim.keymap.set("n", keys, details["func"], { silent = true, buffer = args.buf, desc = details["desc"] })
		end
	end,
})
