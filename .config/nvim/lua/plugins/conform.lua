-- conform.nvim runs formatters (LazyVim wires it as the primary formatter, falling
-- back to LSP formatting when no conform formatter matches the buffer).
--
-- Why this file exists: JetBrains' kotlin-lsp formats `.kt` source files but returns
-- a null response for Kotlin *script* files (`*.kts`, e.g. build.gradle.kts), so those
-- never get formatted. We route only `.kts` through ktlint and leave `.kt` on the LSP.
return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- Neovim gives both `.kt` and `.kts` the `kotlin` filetype, so decide per-buffer:
      --   *.kts -> ktlint (kotlin-lsp declines to format scripts)
      --   *.kt  -> {} so conform stays inactive and LazyVim falls back to kotlin-lsp
      kotlin = function(bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name:match("%.kts$") then
          return { "ktlint" }
        end
        return {}
      end,
    },
  },
}
