-- A dark and light Neovim theme written in Lua ported from the Visual Studio Code TokyoNight
-- theme. Includes extra themes for Kitty, Alacritty, iTerm and Fish.
return {
  "folke/tokyonight.nvim",
  opts = {
    style = "night",
    transparent = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = false },

      sidebars = "transparent",
      floats = "transparent",
    },
    on_colors = function(_) end,
    on_highlights = function(highlights, _)
      highlights.Comment = { fg = "#928374", italic = true }
      highlights.WinSeparator = { link = "VirtColumn" }
    end,
  },
}
