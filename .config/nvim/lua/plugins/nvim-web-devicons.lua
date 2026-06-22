-- Provides Nerd Font icons (glyphs) for use by neovim plugins.
return {
  "nvim-tree/nvim-web-devicons",
  opts = {
    override = {
      rs = {
        icon = "🦀",
      },
      py = {
        icon = "🐸",
      },
      ts = {
        icon = "",
      },
      js = {
        icon = "",
      },
    },
  },
}
