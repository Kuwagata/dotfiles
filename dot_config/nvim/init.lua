if vim.env.VSCODE then
  vim.g.vscode = true
end

if vim.loader then
  vim.loader.enable()
end

require('config.lazy')

-- require("core")
--
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not vim.loop.fs_stat(lazypath) then
-- 	vim.fn.system({
-- 		"git",
-- 		"clone",
-- 		"--filter=blob:none",
-- 		"https://github.com/folke/lazy.nvim.git",
-- 		"--branch=stable",
-- 		lazypath,
-- 	})
-- end
-- vim.opt.rtp:prepend(lazypath)
-- require("lazy").setup("plugins", {
-- 	dev = {
-- 		path = "~/Projects/Neovim",
-- 		fallback = false,
-- 	},
-- })
-- require("plugin_configs")
--
-- require("lsp")
-- require("mappings")
-- require("appearance")
