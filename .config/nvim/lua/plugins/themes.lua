return {
  -- Color scheme.
  {
    "folke/tokyonight.nvim",
    enabled = true,
    opts = {
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",

        keywords = { italic = true },
      },
      on_highlights = function(hl, c)
        -- Customize comment color.
        hl.Comment = { fg = "#928374", italic = false }
      end,
      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.bg = "#000000"
      end,
    },
  },

  -- File icon theme
  { "nvim-mini/mini.icons", enabled = false }, -- Disable default file icon theme.
  {
    "nvim-tree/nvim-web-devicons",
    enabled = true,
    opts = function()
      return {
        override = {
          rs = {
            icon = "🦀",
          },
          cue = {
            icon = "🐚",
          },
          py = {
            icon = "🐸",
          },
        },
      }
    end,
  },
}
