return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "folke/neodev.nvim" },
			{ "Hoffs/omnisharp-extended-lsp.nvim" },
			{ "Issafalcon/lsp-overloads.nvim" },
		},
		-- event = { "BufReadPre", "BufNewFile" },
		event = "VeryLazy",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"lua_ls",
					"eslint",
					"omnisharp",
					"gopls",
					-- "bicep",
					"yamlls",
					"marksman",
					-- "terraformls",
					-- "helm_ls"
				},
				auto_install = true,
			})
			require("neodev").setup({
				library = {
					plugins = {
						"nvim-dap-ui",
					},
					types = true,
				},
			})

			-- Specify how the border looks like
			local border = {
				{ "┌", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "┐", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "┘", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "└", "FloatBorder" },
				{ "│", "FloatBorder" },
			}

			-- Add the border on hover and on signature help popup window
			local handlers = {
				["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
				["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
			}

			-- Add border to the diagnostic popup window
			vim.diagnostic.config({
				virtual_text = {
					prefix = "■ ", -- Could be '●', '▎', 'x', '■', , 
				},
				float = { border = border },
			})

			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end)
			vim.keymap.set("n", "<leader>vn", function()
				vim.diagnostic.goto_next()
			end)
			vim.keymap.set("n", "<leader>vb", function()
				vim.diagnostic.goto_prev()
			end)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					local function filter(arr, fn)
						if type(arr) ~= "table" then
							return arr
						end

						local filtered = {}
						for k, v in pairs(arr) do
							if fn(v, k, arr) then
								table.insert(filtered, v)
							end
						end

						return filtered
					end

					local function filterReactDTS(value)
						return string.match(value.filename, "index.d.ts") == nil
					end

					local function on_list(options)
						local items = options.items
						if #items > 1 then
							items = filter(items, filterReactDTS)
						end
						vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })
						vim.api.nvim_command("cfirst") -- or maybe you want 'copen' instead of 'cfirst'
					end

					vim.keymap.set("n", "<F4>", function()
						vim.lsp.buf.code_action()
					end, opts)
					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition({ on_list = on_list })
					end, opts)
					-- vim.keymap.set("n", "gd", function()
					-- 	vim.lsp.buf.definition()
					-- end, opts)
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, opts)
					vim.keymap.set("n", "<leader>vws", function()
						vim.lsp.buf.workspace_symbol()
					end, opts)
					--vim.keymap.set("n", "<leader>vd", function() vim.lsp.buf.open_float() end, opts)
					vim.keymap.set("n", "<leader>vca", function()
						vim.lsp.buf.code_action()
					end, opts)
					-- vim.keymap.set("n", "<leader>vrr", function()
					-- 	vim.lsp.buf.references()
					-- end, opts)
					vim.keymap.set("n", "<leader>vrn", function()
						vim.lsp.buf.rename()
					end, opts)
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local omni_attach = function(client, bufnr)
				require("lsp-overloads").setup(client, {})
			end

			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				handlers = handlers,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				handlers = handlers,
			})
			lspconfig.marksman.setup({

				capabilities = capabilities,
				handlers = handlers,
			})
			lspconfig.gopls.setup({

				capabilities = capabilities,
				handlers = handlers,
			})
			lspconfig.yamlls.setup({
				capabilities = capabilities,
				handlers = handlers,
				settings = {
					yaml = {
						validate = true,
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = {
							kubernetes = "k8s-*.yaml",
							["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
							["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
							["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
							["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
							["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
							["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
							["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
							["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
						},
					},
				},
			})
			lspconfig.eslint.setup({
				--- ...
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})

			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				on_attach = omni_attach,
				settings = {
					FormattingOptions = {
						-- Enables support for reading code style, naming convention and analyzer
						-- settings from .editorconfig.
						EnableEditorConfigSupport = true,
						-- Specifies whether 'using' directives should be grouped and sorted during
						-- document formatting.
						OrganizeImports = nil,
					},
					MsBuild = {
						-- If true, MSBuild project system will only load projects for files that
						-- were opened in the editor. This setting is useful for big C# codebases
						-- and allows for faster initialization of code navigation features only
						-- for projects that are relevant to code that is being edited. With this
						-- setting enabled OmniSharp may load fewer projects and may thus display
						-- incomplete reference lists for symbols.
						LoadProjectsOnDemand = nil,
					},
					RoslynExtensionsOptions = {
						-- Enables support for roslyn analyzers, code fixes and rulesets.
						EnableAnalyzersSupport = true,
						-- Enables support for showing unimported types and unimported extension
						-- methods in completion lists. When committed, the appropriate using
						-- directive will be added at the top of the current file. This option can
						-- have a negative impact on initial completion responsiveness,
						-- particularly for the first few completion sessions after opening a
						-- solution.
						EnableImportCompletion = true,
						-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
						-- true
						AnalyzeOpenDocumentsOnly = false,
					},
					Sdk = {
						-- Specifies whether to include preview versions of the .NET SDK when
						-- determining which version to use for project loading.
						IncludePrereleases = true,
					},
				},
				filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx" },
				-- handlers = {
				-- 	["textDocument/definition"] = require("omnisharp_extended").handler,
				-- },
				handlers = {
					["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
					["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
					["textDocument/definition"] = require("omnisharp_extended").definition_handler,
					["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
					["textDocument/references"] = require("omnisharp_extended").references_handler,
					["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
				},
			})
		end,
	},
}
