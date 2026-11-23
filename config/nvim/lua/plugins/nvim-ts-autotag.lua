return {
	"windwp/nvim-ts-autotag",
	ft = { "html", "javascript", "javascriptreact", "typescriptreact", "vue", "svelte" },
	config = function()
		require("nvim-ts-autotag").setup({})
	end,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}
