-- Neorg is an all-encompassing tool based around structured note taking, project and task
-- management, time tracking, slideshows, writing typeset documents and much more. The premise is
-- that all of these features are built on top of a single base file format (.norg).
return {
  {
    "pysan3/pathlib.nvim",
    priority = 1000
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    dependencies = { "pysan3/pathlib.nvim" },
    config = true
  },
  {
    "nvim-neorg/neorg",
    dependencies = {
      { "luarocks.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    version = "*",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                wiki = "~/Documents/wiki",
              },
              default_workspace = "wiki",
            },
          },
        },
      }
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  }
}
