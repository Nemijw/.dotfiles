return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			-- "windwp/nvim-autopairs",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			-- require("nvim-autopairs").setup()
			--cmp
			-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			-- local handlers = require("nvim-autopairs.completion.handlers")

			local cmp = require("cmp")

			-- cmp.event:on(
			-- 	"confirm_done",
			-- 	cmp_autopairs.on_confirm_done({
			-- 		filetypes = {
			-- 			-- "*" is a alias to all filetypes
			-- 			["*"] = {
			-- 				["("] = {
			-- 					kind = {
			-- 						cmp.lsp.CompletionItemKind.Function,
			-- 						cmp.lsp.CompletionItemKind.Method,
			-- 						cmp.lsp.CompletionItemKind.Constant,
			-- 					},
			-- 					handler = handlers["*"],
			-- 				},
			-- 			},
			-- 			-- Disable for tex
			-- 			tex = false,
			-- 		},
			-- 	})
			-- )

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/nemi/snippets.lua" })

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "buffer",  keyword_length = 3 },
					{ name = "luasnip", keyword_length = 2 },
				},
				-- formatting = lsp_zero.cmp_format(),
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
			})

			--Setup vim-dadbod
			cmp.setup.filetype({ "sql" }, {
				sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "buffer" },
				},
			})

			local ls = require("luasnip")
			vim.keymap.set({ "i", "s" }, "<C-Q>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
-- end
-- 		}, -- Required
-- }
