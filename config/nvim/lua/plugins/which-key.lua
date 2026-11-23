return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		require("which-key").add({
			{ "<leader>g", group = "Git" },
			{ "<leader>t", group = "Tabs/Splits" },
			{ "<leader>f", group = "Files/Telescope" },
			{ "<leader>p", group = "Project" },
			{ "<leader>y", group = "Yank/Clipboard" },
		})
	end,
}
