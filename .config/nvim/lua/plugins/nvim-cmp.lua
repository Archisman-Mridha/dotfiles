-- For autocompletion.
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      opts = { src = { cmp = { enabled = true } } }
    }
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    opts.sources = opts.sources or {}
    table.insert(opts.sources, { name = "crates" })
  end,
  config = function ( )
    local cmp= require("cmp")

    cmp.setup({
      enabled = function()
        if require"cmp.config.context".in_treesitter_capture("comment")==true or require"cmp.config.context".in_syntax_group("Comment") then
          return false
        else
          return true
        end
      end
    })
  end
}
