return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local langs = {
			"c",
			"cpp",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"rust",
			"tsx",
			"typescript",
			"tmux",
			"sql",
			"python",
			"html",
			"go",
			"css",
			"cmake",
			"bash",
			"arduino",
			"json",
			"yaml",
			"toml",
		}

		require("nvim-treesitter").install(langs)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
