local lazy_nvim_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Ensure that lazy.nvim is bootstrapped.
if not vim.loop.fs_stat(lazy_nvim_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy_nvim_path,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazy_nvim_path)

require("lazy").setup({
  spec = {
    -- Add LazyVim and import its plugins.
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Disable some plugins which come bundled with Lazy.nvim.
    { "catppuccin/nvim", enabled = false },
    { "folke/todo-comments.nvim", enabled = false },
    { "akinsho/bufferline.nvim", enabled = false },
    { "nvim-mini/mini.icons", enabled = false },

    -- import / override with your plugins.
    { import = "plugins" },
  },

  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom
    -- plugins will load during startup.
    -- When you know what you're doing, you can set this to true to have all
    -- your custom plugins lazy-loaded by default.
    lazy = false,

    -- It's recommended to leave version=false for now, since a lot the plugin
    -- that support versioning, have outdated releases, which may break your
    -- Neovim install.
    version = false, -- always use the latest git commit.
  },

  install = { colorscheme = { "tokyonight" } },

  -- Automatically check for plugin updates.
  checker = { enabled = true, notify = false },

  performance = {
    rtp = {
      -- Disable some rtp plugins.
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
