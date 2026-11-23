return {
  "rebelot/kanagawa.nvim",
  lazy = false,        -- load at startup
  priority = 1000,     -- high so it applies before other themes/highlights
  opts = {
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    functionStyle = {},
    typeStyle = {},
    transparent = false,       -- set true if you want transparency by default
    dimInactive = true,        -- dim inactive windows
    terminalColors = true,     -- set terminal colors
    theme = "dragon",          -- default variant
    background = { dark = "dragon", light = "lotus" },
    -- example overrides: make floats transparent and remove gutter bg
    overrides = function(colors)
      return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        SignColumn = { bg = "none" },
        LineNr = { bg = "none" },
      }
    end,
  },
   -- minimal config: ensure setup is applied (safe) and then colorscheme + keymaps
  config = function(_, opts)
    -- ensure the setup is applied with opts (lazy will normally call setup for you,
    -- but calling it here is harmless and explicit)
    require("kanagawa").setup(opts)

    -- Apply the colorscheme
    vim.cmd("colorscheme kanagawa")

    -- Keymaps: toggle/load variants (leader + k{w,d,l})
    vim.keymap.set("n", "<leader>kw", function()
      require("kanagawa").load("wave")
    end, { desc = "Kanagawa: wave" })

    vim.keymap.set("n", "<leader>kd", function()
      require("kanagawa").load("dragon")
    end, { desc = "Kanagawa: dragon" })

    vim.keymap.set("n", "<leader>kl", function()
      require("kanagawa").load("lotus")
    end, { desc = "Kanagawa: lotus" })
  end,

}
