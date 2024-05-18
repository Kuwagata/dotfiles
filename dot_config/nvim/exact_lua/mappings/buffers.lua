-- Unused in favor of telescope
local function num_buffers()
	-- Change this if there's ever an easier way to get the number of buffers in lua
	return vim.fn.len(vim.fn.getbufinfo({ buflisted = true }))
end

local function smart_buf()
	-- Wildcard expansion of one item autocompletes, making <S-Tab> print out verbatim
	return num_buffers() > 1 and ":buffer <C-Z><S-Tab>" or ""
end

local function smart_split_buf()
	-- Wildcard expansion of one item autocompletes, making <S-Tab> print out verbatim
	return num_buffers() > 1 and ":sbuffer <C-Z><S-Tab>" or ""
end

-- Buffer switching
-- vim.keymap.set("n", "<leader>b", smart_buf, { desc = "Smart buffer switch", expr = true })
-- vim.keymap.set("n", "<leader>B", smart_split_buf, { desc = "Smart buffer switch (split)", expr = true })
