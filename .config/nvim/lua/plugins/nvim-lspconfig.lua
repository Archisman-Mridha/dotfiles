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
      gopls = {
        settings = {
          gopls = {
            staticcheck = false,
          },
        },
      },
    },
  },
}
