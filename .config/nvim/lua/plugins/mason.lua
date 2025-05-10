-- To easily install and manage LSP servers, DAP servers, linters, and formatters.
return {
  "mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "golangci-lint",
      "haskell-language-server",
      "nil",
      "nixfmt",
      "nixpkgs-fmt",
      "ols",
      "zls",
      "graphql-language-service-cli",
      "biome",
      "hyprls",
    })
  end,
}
