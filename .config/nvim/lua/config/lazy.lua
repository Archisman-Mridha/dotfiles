local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	-- stylua: ignore
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	spec = {
		-- add LazyVim and import its plugins
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },

		-- Telescope
		{ import = "lazyvim.plugins.extras.editor.telescope" },

		-- Symbols outline
		{ import = "lazyvim.plugins.extras.editor.outline" },

		-- Better navigation
		{ import = "lazyvim.plugins.extras.editor.leap" },

		-- Languages
		{ import = "lazyvim.plugins.extras.lang.go" },
		{ import = "lazyvim.plugins.extras.lang.yaml" },
		{ import = "lazyvim.plugins.extras.lang.docker" },
		{ import = "lazyvim.plugins.extras.lang.helm" },
		{ import = "lazyvim.plugins.extras.lang.markdown" },
		{ import = "lazyvim.plugins.extras.lang.nix" },
		{ import = "lazyvim.plugins.extras.lang.ocaml" },
		{ import = "lazyvim.plugins.extras.lang.prisma" },
		{ import = "lazyvim.plugins.extras.lang.python" },
		{ import = "lazyvim.plugins.extras.lang.rust" },
		{ import = "lazyvim.plugins.extras.lang.toml" },
		{ import = "lazyvim.plugins.extras.lang.sql" },
		{ import = "lazyvim.plugins.extras.lang.tailwind" },
		{ import = "lazyvim.plugins.extras.lang.terraform" },
		{ import = "lazyvim.plugins.extras.lang.typescript" },
		{ import = "lazyvim.plugins.extras.lang.json" },
		{ import = "lazyvim.plugins.extras.lang.clangd" },
		{ import = "lazyvim.plugins.extras.util.dot" },
		{ import = "lazyvim.plugins.extras.lang.gleam" },

		-- Cycle through yank history
		{ import = "lazyvim.plugins.extras.coding.yanky" },

		-- Better annotation generator
		{ import = "lazyvim.plugins.extras.coding.neogen" },

		-- For automatically highlighting other uses of the word under the cursor using either LSP,
		-- Tree-sitter, or regex matching.
		{ import = "lazyvim.plugins.extras.editor.illuminate" },

		-- Incremental LSP renaming based on Neovim's command-preview feature.
		{ import = "lazyvim.plugins.extras.editor.inc-renam" },

		-- Formatting
		{ import = "lazyvim.plugins.extras.formatting.prettier" },

		-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
		{ import = "lazyvim.plugins.extras.lsp.none-ls" },

		-- Visualize and operate on indent scope.
		{ import = "lazyvim.plugins.extras.ui.mini-indentscope" },

		-- Show code context
		{ import = "lazyvim.plugins.extras.ui.treesitter-context" },

		-- Highlight patterns in text.
		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },

		-- import/override with your plugins
		{ import = "plugins" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	install = { colorscheme = { "tokyonight" } },
	checker = { enabled = true, notify = false }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
