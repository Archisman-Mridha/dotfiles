return {
  -- Color scheme.
  {
    "sainnhe/gruvbox-material",
    enabled = false,
    config = function()
      vim.g.gruvbox_material_enable_italic = false
      vim.g.gruvbox_material_disable_italic_comment = true
      vim.g.gruvbox_material_float_style = "blend"
      vim.g.gruvbox_material_ui_contrast = "high"
      vim.g.gruvbox_material_transparent_background = "2"
      vim.g.gruvbox_material_background = "hard"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = true,
    opts = {
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",

        keywords = { italic = true },
      },
      on_highlights = function(hl, c)
        hl.Comment = { fg = "#928374", italic = false }

        hl.Statement = { fg = hl.Statement and hl.Statement.fg or c.magenta, italic = true }
        hl.Conditional = { fg = hl.Conditional and hl.Conditional.fg or c.magenta, italic = true }
        hl.Repeat = { fg = hl.Repeat and hl.Repeat.fg or c.magenta, italic = true }
        hl.Keyword = { fg = hl.Keyword and hl.Keyword.fg or c.purple, italic = true }
      end,
      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.bg = "#000000"
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")

      local italic_comment_ns = vim.api.nvim_create_namespace("italic_comments")
      vim.api.nvim_set_hl(italic_comment_ns, "Comment", { fg = "#928374", italic = true })

      local italic_fts = { yaml = true, python = true, dockerfile = true, nix = true, conf = true, bzl = true }

      vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
        callback = function()
          if italic_fts[vim.bo.filetype] then
            vim.api.nvim_win_set_hl_ns(0, italic_comment_ns)
          else
            vim.api.nvim_win_set_hl_ns(0, 0)
          end
        end,
      })
    end,
  },

  -- File icon theme
  { "nvim-mini/mini.icons", enabled = false }, -- Disable default file icon theme.
  {
    "nvim-tree/nvim-web-devicons",
    enabled = true,
    opts = function()
      return {
        override = {
          rs = {
            icon = "🦀",
          },
          cue = {
            icon = "🐚",
          },
          py = {
            icon = "🐸",
          },
          ts = {
            icon = "",
          },
        },
      }
    end,
  },
}
