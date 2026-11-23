-- autocmd.lua
local augroup = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

local my_group = augroup("user_autocmds", { clear = true })

-- highlight on yank
au("TextYankPost", {
	group = my_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 120 })
	end,
})

-- trim trailing whitespace on save, except in delimited data files
au("BufWritePre", {
	group = my_group,
	pattern = "*",
	callback = function(ev)
		local ft = vim.bo[ev.buf].filetype
		if ft == "csv" or ft == "tsv" then
			return
		end
		vim.cmd([[%s/\s\+$//e]])
	end,
})

-- Example: set filetype/indent for certain patterns (add as needed)
-- au("FileType", { group = my_group, pattern = "python", command = "setlocal tabstop=4 shiftwidth=4" })
