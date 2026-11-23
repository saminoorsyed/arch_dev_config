-- lua/mappings.lua
-- Single file containing user mappings + which-key registration

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- General
vim.g.diagnostics_virtual_lines = true
vim.diagnostic.config({ virtual_lines = vim.g.diagnostics_virtual_lines })
local function toggle_virtual_lines()
	vim.g.diagnostics_virtual_lines = not vim.g.diagnostics_virtual_lines
	vim.diagnostic.config({ virtual_lines = vim.g.diagnostics_virtual_lines })
	if vim.g.diagnostics_virtual_lines then
		vim.notify("Diagnostics: virtual_lines ON")
	else
		vim.notify("Diagnostics: virtual_lines OFF")
	end
end
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap("n", "x", '"_x', { desc = "Delete char without yanking" })
keymap("i", "jk", "<esc>", { desc = "Exit insert mode with jk" })
keymap("n", "<leader>tr", "<cmd>set relativenumber!<CR>", { desc = "Toggle relativenumber" })
keymap("n", "<leader>tl", toggle_virtual_lines, { desc = "Toggle linter virtual_lines" })
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
keymap("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown preview" })
keymap("n", "<leader>cv", "<cmd>CsvViewToggle<CR>", { desc = "Toggle CSV view" })

-- Window & Tab Management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sa", "<C-w>s", { desc = "Split window across the screen" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- Window & Tab navigation
keymap("n", "<leader>sh", "<C-w>h", { desc = "switch left a window" })
keymap("n", "<leader>sj", "<C-w>j", { desc = "switch down a window" })
keymap("n", "<leader>sk", "<C-w>k", { desc = "switch up a window" })
keymap("n", "<leader>sl", "<C-w>l", { desc = "switch right a window" })

-- Tabs
keymap("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })
keymap("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab" })
keymap("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab" })

-- Navigation / Quickfix
keymap("n", "<C-j>", "<cmd>cnext<CR>", { desc = "Quickfix next" })
keymap("n", "<C-k>", "<cmd>cprev<CR>", { desc = "Quickfix prev" })

-- Telescope (file finding)
keymap("n", "<C-p>", "<cmd>Telescope git_files<CR>", { desc = "Find Git files" })
keymap("n", "<leader>pf", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files (alt)" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })

-- Git (Fugitive)
keymap("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
keymap("n", "<leader>gb", "<cmd>G blame<CR>", { desc = "Git blame" })
keymap("n", "<leader>gd", "<cmd>Gdiffsplit<CR>", { desc = "Git diff split" })
keymap("n", "<leader>gc", "<cmd>Git commit<CR>", { desc = "Git commit" })
keymap("n", "<leader>gp", "<cmd>Git push<CR>", { desc = "Git push" })

-- Clipboard / Yank / Paste
keymap("v", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })
keymap("v", "<leader>y", '"+y', { desc = "Yank to system clipboard (visual)" })
keymap("n", "<leader>y", '"+y', { desc = "Yank to system clipboard (normal)" })
keymap("n", "<leader>Y", 'gg"+yG', { desc = "Yank whole file to system clipboard" })

-- Moving Text
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Spell suggestions (wraps your function defined in options.lua)
-- Call using z=
keymap("n", "z=", function()
	-- if our Lua function exists, call it, otherwise fallback to default z=
	if type(_G.SpellSuggestPopup) == "function" then
		_G.SpellSuggestPopup()
		return
	end
	-- fallback
	vim.fn["z="]()
end, { desc = "Show spell suggestions in a popup" }) -- LSP-style buffer maps will be attached in the LSP on_attach handler
-- Leader group names are registered in lua/plugins/which-key.lua.
