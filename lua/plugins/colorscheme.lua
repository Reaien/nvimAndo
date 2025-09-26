return {
  {
    -- Dracula theme
    { "Mofiqul/dracula.nvim" },

    -- Otros themes que ya tienes instalados
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      opts = {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        term_colors = true,
      },
    },
    {
      "Gentleman-Programming/gentleman-kanagawa-blur",
      name = "gentleman-kanagawa-blur",
      priority = 1000,
    },
    {
      "Alan-TheGentleman/oldworld.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    },
    {
      "rebelot/kanagawa.nvim",
      priority = 1000,
      lazy = true,
      config = function()
        require("kanagawa").setup({
          compile = false,
          undercurl = true,
          commentStyle = { italic = true },
          keywordStyle = { italic = true },
          statementStyle = { bold = true },
          transparent = true,
          terminalColors = true,
          colors = {
            palette = {},
            theme = {
              all = {
                ui = {
                  bg_gutter = "none",
                  bg_sidebar = "none",
                  bg_float = "none",
                },
              },
            },
          },
          overrides = function(colors)
            return {
              LineNr = { bg = "none" },
              NormalFloat = { bg = "none" },
              FloatBorder = { bg = "none" },
              FloatTitle = { bg = "none" },
              TelescopeNormal = { bg = "none" },
              TelescopeBorder = { bg = "none" },
              LspInfoBorder = { bg = "none" },
            }
          end,
          theme = "wave",
          background = {
            dark = "wave",
            light = "lotus",
          },
        })
      end,
    },

    -- Aquí le dices a LazyVim cuál usar por defecto
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "dracula", -- 👈 ahora usará Dracula
      },
    },
  },
}
