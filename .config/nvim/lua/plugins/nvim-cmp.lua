return {
  "Saghen/blink.cmp",
  opts = {
    completion = {
      menu = {
        border = "rounded",
        winblend = 0,
        winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
          winblend = 0,
        },
      },
    },

    fuzzy = {
      implementation = "prefer_rust",
    },
  },
}
