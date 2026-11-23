-- Options/ basic settings for neovim
-- Options (equivalents of your set ... lines)
local o = vim.opt
o.scrolloff = 8
o.number = true
o.relativenumber = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.termguicolors = true
o.virtualedit = "block"
o.inccommand = "split"
-- o.ignorecase = true
o.spelllang = "en_us"
o.spell = true

-- expose explicitly as a global so other modules can call it
_G.SpellSuggestPopup = function()
	local suggestions = vim.fn.spellsuggest(vim.fn.expand("<cword>"))
	if not vim.tbl_isempty(suggestions) then
		local bufnr = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, suggestions)
		local win = vim.api.nvim_open_win(bufnr, true, {
			relative = "cursor",
			width = 30,
			height = #suggestions,
			row = 1,
			col = 0,
			border = "single",
		})
		local function apply_suggestion()
			local word = vim.api.nvim_get_current_line()
			local prev = vim.fn.getreg("z")
			local prev_type = vim.fn.getregtype("z")
			vim.api.nvim_win_close(win, true)
			vim.fn.setreg("z", word, "c")
			vim.cmd('normal! "_diw"zP')
			vim.fn.setreg("z", prev, prev_type)
		end
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = bufnr, silent = true })
		vim.keymap.set("n", "<CR>", apply_suggestion, { buffer = bufnr, silent = true })
	end
end

-- Colorscheme (will error if not installed). Use pcall to avoid startup error.
-- pcall(vim.cmd, "colorscheme zaibatsu")
