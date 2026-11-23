-- init.lua (loads modular config)
-- Files live under: ~/.config/nvim/lua/
-- ~/.config/nvim/init.lua (top)

-- Mason installs formatters and language servers here. Prepend it so Conform
-- can see them, including after the directory is created mid-session.
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":" .. vim.env.PATH

-- core modules (options, keymaps, autocmds)
require("options")
require("mappings")
require("autocmd")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from lua/plugins/*.lua

require("lazy").setup("plugins", {
	git = { url_format = "https://github.com/%s.git" },
	hererocks = { enabled = false },
})
