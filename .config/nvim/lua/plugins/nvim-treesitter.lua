-- Provides a simple and easy way to use the interface for Treesitter (used for parser generation
-- and an incremental parsing).
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {

        -- Rust
        "ron",
        "rust",
        "toml",

        -- GoLang
        "go",
        "gomod",
        "gowork",
        "gosum",

        -- Typescript
        "typescript",
        "tsx",

        -- Terraform and HCL
        "terraform",
        "hcl",

        -- YAML
        "yaml",

        -- JSON
        "json",
        "json5",
        "jsonc",

        -- Dockerfile
        "dockerfile",

        -- Markdown
        "markdown",
        "markdown_inline"
      })
    end
  end,
}
