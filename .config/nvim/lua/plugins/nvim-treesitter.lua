return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "nix",
        "cue",
        "http",
        "graphql",
        "html",
        "jsonnet",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    opts = {
      refactor = {
        smart_rename = {
          enable = true,
          keymaps = {
            smart_rename = "<leader>rf",
          },
        },
      },
    },
  },
}
