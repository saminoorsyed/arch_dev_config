return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	event = "InsertEnter",
	dependencies = { "rafamadriz/friendly-snippets" },
	-- optional: JS-regex snippet triggers (you have gcc + make)
	build = "make install_jsregexp",
	config = function()
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged,TextChangedI",
		})
	end,
}
