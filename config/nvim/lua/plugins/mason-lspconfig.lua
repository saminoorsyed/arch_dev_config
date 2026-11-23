return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"neovim/nvim-lspconfig",
		"saghen/blink.cmp",
	},
	config = function()
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})

		vim.lsp.config("clangd", {
			root_markers = {
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"Makefile",
				".git",
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
			callback = function(ev)
				local bufmap = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
				end
				bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
				bufmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
				bufmap("n", "K", vim.lsp.buf.hover, "Hover")
				bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
				bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
				bufmap("n", "gr", vim.lsp.buf.references, "References")
				bufmap("n", "<leader>fm", function()
					vim.lsp.buf.format({ async = true })
				end, "Format")
			end,
		})

		require("mason-lspconfig").setup({
			-- lspconfig server names. Mason package names differ
			-- (cssls is css-lsp, eslint is eslint-lsp, html is html-lsp).
			ensure_installed = {
				"pyright",
				"lua_ls",
				"gopls",
				"ts_ls",
				"rust_analyzer",
				"clangd",
				"eslint",
				"tailwindcss",
				"html",
				"cssls",
			},
		})
	end,
}
