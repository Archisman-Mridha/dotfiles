-- A dark and light Neovim theme written in Lua ported from the Visual Studio Code TokyoNight
-- theme. Includes extra themes for Kitty, Alacritty, iTerm and Fish.
return {
  "folke/tokyonight.nvim",
  opts = {
    style = "night",
    transparent = true,
    styles = {
      keywords = { italic = true },

      sidebars = "transparent",
      floats = "transparent",
    },
    on_colors = function(_) end,
    on_highlights = function(highlights, colors)
      highlights.Comment = { fg = "#928374", italic = false }
      highlights["@lsp.typemod.comment.documentation.rust"] = { fg = colors.blue, italic = false }
      highlights["@comment.documentation"] = { fg = colors.blue, italic = false } -- if a TS parser is ever installed

      highlights.WinSeparator = { link = "VirtColumn" }
    end,
  },
}
