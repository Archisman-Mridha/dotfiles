-- A collection of small QoL plugins for Neovim.
return {
  "folke/snacks.nvim",
  opts = {
    -- Picker for selecting items.
    picker = {
      sources = {
        -- A file explorer (picker in disguise).
        explorer = {
          hidden = true,
          focus = "list",
          layout = {
            hidden = { "input" },
            auto_hide = { "input" },
            layout = {
              width = 33,
              min_width = 33,
            },
          },
        },
      },

      icons = {
        files = {
          dir = "󰉋",
          dir_open = "󰉖",
          file = "󰈔",
        },

        tree = {
          last = "╰╴",
        },
      },
    },
  },
}
