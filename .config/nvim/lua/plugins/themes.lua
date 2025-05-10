return {
  -- Color scheme.
  {
    "folke/tokyonight.nvim",
    enabled = true,
    opts = {
      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.bg = "#000000"
      end,

      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",

        comments = { italic = false },
        keywords = { italic = false },
      },
      on_highlights = function(hl, c)
        -- Customize comment color.
        hl.Comment = { fg = "#928374", italic = false }
      end,
    },
  },

  -- File icon theme
  { "echasnovski/mini.icons", enabled = false }, -- Disable default file icon theme.
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
        },
      }
    end,
  },
}
