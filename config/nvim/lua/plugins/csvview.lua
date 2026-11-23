return {
	"hat0uma/csvview.nvim",
	ft = { "csv", "tsv" },
	cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	opts = {
		view = { display_mode = "border" },
		parser = {
			delimiter = function(bufnr)
				if vim.bo[bufnr].filetype == "tsv" then
					return "\t"
				end
				return vim.b[bufnr].csv_delimiter or ","
			end,
		},
		keymaps = {
			textobject_field_inner = { "if", mode = { "o", "x" } },
			textobject_field_outer = { "af", mode = { "o", "x" } },
			jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
			jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
			jump_next_row = { "<Enter>", mode = { "n", "v" } },
			jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
		},
	},
	config = function(_, opts)
		local csvview = require("csvview")
		csvview.setup(opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "csv", "tsv" },
			callback = function(ev)
				csvview.enable(ev.buf)
			end,
		})
	end,
}
