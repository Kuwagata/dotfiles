-- Resize splits
for key, cmd in pairs({
	["Left"] = { val = "vertical resize -2", desc = "Resize left" },
	["Right"] = { val = "vertical resize +2", desc = "Resize right" },
	["Up"] = { val = "resize -2", desc = "Resize up" },
	["Down"] = { val = "resize +2", desc = "Resize down" },
}) do
	vim.keymap.set("n", "<C-" .. key .. ">", ":" .. cmd["val"] .. "<CR>", { desc = cmd["desc"], silent = true })
	vim.keymap.set("t", "<C-" .. key .. ">", "<cmd>" .. cmd["val"] .. "<CR>", { desc = cmd["desc"], silent = true })
end

-- Window movement
for key, desc in pairs({
	["h"] = "Navigate left",
	["j"] = "Navigate down",
	["k"] = "Navigate up",
	["l"] = "Navigate right",
}) do
	vim.keymap.set("n", "<A-" .. key .. ">", "<C-w>" .. key, { desc = desc })
	vim.keymap.set("t", "<A-" .. key .. ">", "<cmd>wincmd " .. key .. "<CR>", { desc = desc })
end

vim.keymap.set("n", "<leader>N", ":only<CR>", { desc = "Close all but the current split", silent = true })
