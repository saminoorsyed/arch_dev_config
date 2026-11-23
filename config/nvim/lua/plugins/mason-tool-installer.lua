return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim" },
	config = function()
		-- Mason package names. These are not the lspconfig server names
		-- used in mason-lspconfig.lua (cssls there is css-lsp here, and so on).
		require("mason-tool-installer").setup({
			ensure_installed = {
				"stylua",
				"black",
				"isort",
				"prettierd",
				"prettier",
				"gofumpt",
				"goimports",
				"clang-format",
			},
		})
	end,
}
