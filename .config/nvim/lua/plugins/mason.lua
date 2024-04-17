-- To easily install and manage LSP servers, DAP servers, linters, and formatters.
return {
  "mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "codelldb",
      "goimports", "gofumpt", "delve",
      "js-debug-adapter",
      "hadolint",
      "markdownlint", "marksman",
      "helm-ls"
    })
  end
}
