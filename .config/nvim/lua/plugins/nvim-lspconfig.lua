-- nvim-lspconfig is a collection of LSP server configurations for the Nvim LSP client.
return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      -- We're using the virtual text renderer of the tiny-inline-diagnostics plugin.
      virtual_text = false,
    },
  },
}
