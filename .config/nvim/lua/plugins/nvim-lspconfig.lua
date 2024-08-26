return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {

			-- Rust
			rust_analyzer = {
				keys = {
					{ "K",          "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
					{ "<leader>cR", "<cmd>RustCodeAction<cr>",   desc = "Code Action (Rust)" },
					{
						"<leader>dr",
						"<cmd>RustDebuggables<cr>",
						desc = "Run Debuggables (Rust)",
					},
				},
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							runBuildScripts = true,
						},
						lens = {
							enable = false,
						},
						inlayHints = {
							typeHints = { enable = false },
							bindingModeHints = { enable = false },
							chainingHints = { enable = false },
							closingBraceHints = { enable = false },
							closureCaptureHints = { enable = false },
							closureReturnTypeHints = { enable = false },
							discriminantHints = { enable = false },
							expressionAdjustmentHints = { enable = false },
							genericParameterHints = {
								const = { enable = false },
								lifetime = { enable = false },
								type = { enable = false },
							},
							implicitDrops = { enable = false },
							lifetimeElisionHints = { enable = false },
							parameterHints = { enable = false },
							rangeExclusiveHints = { enable = false },
							reborrowHints = { enable = false },
						},
						diagnostics = {
							enable = true,
						},
						-- Add clippy lints for Rust.
						checkOnSave = {
							allFeatures = true,
							command = "clippy",
							extraArgs = { "--no-deps" },
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
					},
				},
			},
			taplo = {
				keys = {
					{
						"K",
						function()
							if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
								require("crates").show_popup()
							else
								vim.lsp.buf.hover()
							end
						end,
						desc = "Show Crate Documentation",
					},
				},
			},

			-- GoLang
			gopls = {
				gofumpt = true,
				codelenses = {
					gc_details = false,
					generate = true,
					regenerate_cgo = true,
					run_govulncheck = true,
					test = true,
					tidy = true,
					upgrade_dependency = true,
					vendor = true,
				},
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				analyses = {
					fieldalignment = true,
					nilness = true,
					unusedparams = true,
					unusedwrite = true,
					useany = true,
				},
				usePlaceholders = true,
				completeUnimported = true,
				staticcheck = true,
				directoryFilters = {
					"-.git",
					"-.vscode",
					"-.idea",
					"-.vscode-test",
					"-node_modules",
				},
				semanticTokens = true,
			},

			-- Typescript
			tsserver = {
				enabled = false,
			},
			vtsls = {
				-- explicitly add default filetypes, so that we can extend
				-- them in related extras
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				settings = {
					complete_function_calls = true,
					vtsls = {
						enableMoveToFileCodeAction = true,
						autoUseWorkspaceTsdk = true,
						experimental = {
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
						inlayHints = {
							enumMemberValues = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							parameterNames = { enabled = "literals" },
							parameterTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							variableTypes = { enabled = false },
						},
					},
				},
				keys = {
					{
						"gD",
						function()
							local params = vim.lsp.util.make_position_params()
							LazyVim.lsp.execute({
								command = "typescript.goToSourceDefinition",
								arguments = { params.textDocument.uri, params.position },
								open = true,
							})
						end,
						desc = "Goto Source Definition",
					},
					{
						"gR",
						function()
							LazyVim.lsp.execute({
								command = "typescript.findAllFileReferences",
								arguments = { vim.uri_from_bufnr(0) },
								open = true,
							})
						end,
						desc = "File References",
					},
					{
						"<leader>co",
						LazyVim.lsp.action["source.organizeImports"],
						desc = "Organize Imports",
					},
					{
						"<leader>cM",
						LazyVim.lsp.action["source.addMissingImports.ts"],
						desc = "Add missing imports",
					},
					{
						"<leader>cu",
						LazyVim.lsp.action["source.removeUnused.ts"],
						desc = "Remove unused imports",
					},
					{
						"<leader>cD",
						LazyVim.lsp.action["source.fixAll.ts"],
						desc = "Fix all diagnostics",
					},
					{
						"<leader>cV",
						function()
							LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
						end,
						desc = "Select TS workspace version",
					},
				},
			},

			-- Terraform
			terraformls = {},

			-- Dockerfile
			dockerls = {},
			docker_compose_language_service = {},

			-- JSON
			jsonls = {
				-- lazy-load schemastore when needed
				on_new_config = function(new_config)
					new_config.settings.json.schemas = new_config.settings.json.schemas or {}
					vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
				end,
				settings = {
					json = { format = { enable = true }, validate = { enable = true } },
				},
			},

			-- YAML
			yamlls = {
				-- Have to add this for yamlls to understand that we support line folding
				capabilities = {
					textDocument = {
						foldingRange = { dynamicRegistration = false, lineFoldingOnly = true },
					},
				},
				-- lazy-load schemastore when needed
				on_new_config = function(new_config)
					new_config.settings.yaml.schemas =
							vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
				end,
				settings = {
					redhat = { telemetry = { enabled = false } },
					yaml = {
						keyOrdering = false,
						format = { enable = true },
						validate = true,
						schemaStore = {
							-- Must disable built-in schemaStore support to use
							-- schemas from SchemaStore.nvim plugin
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
					},
				},
			},

			-- Helm
			helm_ls = {},

			-- Markdown
			marksman = {},

			-- Swift
			sourcekit = {},

			-- Nix
			nil_ls = {},
		},
		setup = {

			rust_analyzer = function(_, opts)
				local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
				require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
				return true
			end,

			gopls = function(_, opts)
				-- workaround for gopls not supporting semanticTokensProvider
				-- https://github.com/golang/go/issues/54531#issuecomment-1464982242
				require("lazyvim.util").lsp.on_attach(function(client, _)
					if client.name == "gopls" then
						if not client.server_capabilities.semanticTokensProvider then
							local semantic = client.config.capabilities.textDocument.semanticTokens
							client.server_capabilities.semanticTokensProvider = {
								full = true,
								legend = {
									tokenTypes = semantic.tokenTypes,
									tokenModifiers = semantic.tokenModifiers,
								},
								range = true,
							}
						end
					end
				end)
				-- end workaround
			end,

			yamlls = function()
				-- Neovim < 0.10 does not have dynamic registration for formatting
				if vim.fn.has("nvim-0.10") == 0 then
					LazyVim.lsp.on_attach(function(client, _)
						if client.name == "yamlls" then
							client.server_capabilities.documentFormattingProvider = true
						end
					end)
				end
			end,

			tsserver = function()
				-- disable tsserver
				return true
			end,
			vtsls = function(_, opts)
				LazyVim.lsp.on_attach(function(client, buffer)
					client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
						---@type string, string, lsp.Range
						local action, uri, range = unpack(command.arguments)

						local function move(newf)
							client.request("workspace/executeCommand", {
								command = command.command,
								arguments = { action, uri, range, newf },
							})
						end

						local fname = vim.uri_to_fname(uri)
						client.request("workspace/executeCommand", {
							command = "typescript.tsserverRequest",
							arguments = {
								"getMoveToRefactoringFileSuggestions",
								{
									file = fname,
									startLine = range.start.line + 1,
									startOffset = range.start.character + 1,
									endLine = range["end"].line + 1,
									endOffset = range["end"].character + 1,
								},
							},
						}, function(_, result)
							---@type string[]
							local files = result.body.files
							table.insert(files, 1, "Enter new path...")
							vim.ui.select(files, {
								prompt = "Select move destination:",
								format_item = function(f)
									return vim.fn.fnamemodify(f, ":~:.")
								end,
							}, function(f)
								if f and f:find("^Enter new path") then
									vim.ui.input({
										prompt = "Enter move destination:",
										default = vim.fn.fnamemodify(fname, ":h") .. "/",
										completion = "file",
									}, function(newf)
										return newf and move(newf)
									end)
								elseif f then
									move(f)
								end
							end)
						end)
					end
				end, "vtsls")
				-- copy typescript settings to javascript
				opts.settings.javascript =
						vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
			end,
		},
	},
}
