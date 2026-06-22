-- A Neovim plugin for displaying inline diagnostic messages with customizable styles and icons.
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  opts = {
    options = {
      multilines = {
        enabled = true,
        always_show = true,
      },

      show_all_diags_on_cursorline = true,
    },
  },
}
