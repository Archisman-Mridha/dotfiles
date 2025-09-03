return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    document_highlight = {
      enabled = false,
    },
    diagnostics = {
      virtual_text = false,
      signs = false,
    },
    servers = {
      gleam = {},
      prismals = {},

      sourcekit = {
        cmd = { "xcrun", "sourcekit-lsp" },
        filetypes = { "swift", "objective-c", "objective-cpp" },
        root_dir = require("lspconfig.util").root_pattern("Package.swift", "buildServer.json", ".git"),
      },
    },
  },
}
