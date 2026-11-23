return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				file_ignore_patterns = { "node_modules", ".git" },
			},
		})
	end,
}
