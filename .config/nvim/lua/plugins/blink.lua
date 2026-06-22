return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      menu = {
        border = "rounded",
        winhighlight = "Normal:None,FloatBorder:None,CursorLine:BlinkCmpMenuSelection,Search:None",
      },
      documentation = {
        auto_show = true,
        window = {
          border = "rounded",
        },
      },
    },

    fuzzy = {
      implementation = "prefer_rust",
    },
  },
}
