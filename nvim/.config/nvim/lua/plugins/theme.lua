return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, _)
        hl.TelescopeNormal = { bg = "none" }
        hl.TelescopeBorder = { bg = "none" }
        hl.TelescopePromptNormal = { bg = "none" }
        hl.TelescopePromptBorder = { bg = "none" }
        hl.TelescopePromptTitle = { bg = "none" }
        hl.TelescopePreviewTitle = { bg = "none" }
        hl.TelescopeResultsTitle = { bg = "none" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight-moon")
    end,
  },
}
