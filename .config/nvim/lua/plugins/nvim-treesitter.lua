vim.keymap.set("n", "<leader>th", function()
  local hl = vim.fn.synIDattr(vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1), "name")
  print("Highlight group: " .. hl)
end, { desc = "Show highlight group under cursor" })

vim.keymap.set("n", "<leader>tc", function()
  local captures = vim.treesitter.get_captures_at_cursor(0)
  print("Tree-sitter captures: " .. vim.inspect(captures))
end, { desc = "Show Tree-sitter captures under cursor" })

return {
  {
    "nvim-treesitter/nvim-treesitter-refactor",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        refactor = {
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = "<leader>rf",
            },
          },
        },

        ensure_installed = {
          "gleam",
          "haskell",
          "odin",
          "nix",
          "cue",
          "http",
          "graphql",
          "hcl",
          "prisma",
          "html",
        },

        highlight = {
          enable = {},
        },
      })
    end,
  },
}
