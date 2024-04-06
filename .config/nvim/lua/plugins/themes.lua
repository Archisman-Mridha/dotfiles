return {
  {
    "folke/tokyonight.nvim",
    opts = {
      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.bg = "#000000"
      end,

      styles = {
        sidebars = "transparent",
        floats = "transparent",

        comments = { italic = false }
      },
    },
  },
}
