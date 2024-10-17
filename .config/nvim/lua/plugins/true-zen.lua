vim.keymap.set("n", "<leader>zf", ":TwilightEnable<CR>", { desc = "Toggle Twilight" })
vim.keymap.set("n", "<leader>zm", ":TZMinimalist<CR>", { desc = "Toggle minimalist mode" })

return {
  { "folke/twilight.nvim" },
  {
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup {
        integrations = { tmux = true, twilight = true, lualine = true }
      }
    end
  }
}
