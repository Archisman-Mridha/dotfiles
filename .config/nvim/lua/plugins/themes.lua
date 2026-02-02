-- Scalable italic-comments config
local aug = vim.api.nvim_create_augroup("ItalicComments", { clear = true })

-- Filetypes where comments should be italic
local italic_ft = {
  nix = true,
  yaml = true,
  python = true,
  bzl = true,
  dockerfile = true,
  toml = true,
  sh = true,
  gitignore = true,
  tiltfile = true,
}

-- Build an italic version of the current Comment highlight
local function define_comment_italic()
  vim.api.nvim_set_hl(0, "CommentItalic", { italic = true, fg = "#928374" })
end

define_comment_italic()

-- Regenerate CommentItalic when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  group = aug,
  callback = define_comment_italic,
})

-- Apply or remove italic comments dynamically
vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "WinEnter" }, {
  group = aug,
  callback = function(args)
    local win = vim.api.nvim_get_current_win()
    local ft = vim.bo[args.buf].filetype
    local cur = vim.api.nvim_get_option_value("winhighlight", { win = win }) or ""
    local mapping = "Comment:CommentItalic"

    local has = cur:find(mapping, 1, true) ~= nil
    if italic_ft[ft] and not has then
      local new = (cur ~= "" and (cur .. ",") or "") .. mapping
      vim.api.nvim_set_option_value("winhighlight", new, { win = win })
    elseif not italic_ft[ft] and has then
      local new = cur:gsub(mapping, ""):gsub("^,", ""):gsub(",,", ","):gsub(",$", "")
      vim.api.nvim_set_option_value("winhighlight", new, { win = win })
    end
  end,
})

return {
  -- Color scheme.
  {
    "folke/tokyonight.nvim",
    enabled = true,
    opts = {
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",

        comments = { italic = true },
        keywords = { italic = true },
      },
      on_highlights = function(hl, c)
        -- Customize comment color.
        hl.Comment = { fg = "#928374", italic = false }
      end,
      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.bg = "#000000"
      end,
    },
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
        },
      }
    end,
  },
}
