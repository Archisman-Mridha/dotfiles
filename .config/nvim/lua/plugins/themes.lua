return {
  -- Color scheme.
  {
    "projekt0n/github-nvim-theme",
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = {
          -- transparent = true,
        },
      })

      vim.cmd("colorscheme github_dark_default")
    end,
  },
  { "RRethy/vim-illuminate", enabled = false },

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
