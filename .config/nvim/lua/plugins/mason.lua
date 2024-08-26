-- To easily install and manage LSP servers, DAP servers, linters, and formatters.
return {
	"mason.nvim",
	opts = function(_, opts)
		opts.ensure_installed = opts.ensure_installed or {}
		vim.list_extend(opts.ensure_installed, {
			"codelldb",
			"goimports",
			"gofumpt",
			"delve",
			"typescript-language-server",
			"hadolint",
			"markdownlint",
			"marksman",
			"helm-ls",
			"stylua",
			"luacheck",
			"shellcheck",
			"shfmt",
			"tailwindcss-language-server",
			"css-lsp",
			"graphql-language-service-cli",
			"zls",
			"clangd",
		})
		table.insert(opts.ensure_installed, "js-debug-adapter")
	end,
}
