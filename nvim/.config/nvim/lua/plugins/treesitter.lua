return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
		lazy = true,
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = {
					"bash",
					"markdown",
					"markdown_inline",
					"c_sharp",
					"css",
					"scss",
					"html",
					"typescript",
					"javascript",
					"c",
					"lua",
					"vim",
					"dockerfile",
					"vimdoc",
					"query",
					"regex",
					"sql",
					"json",
					"yaml",
					"go",
					"bicep",
					"terraform",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				highlight = {
					enable = true,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same t					                                                                                                               -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.                                                                                        -- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				-- context_commentstring = {
				-- 	enable = true,
				-- 	enable_autocmd = false,
				-- },
				autotag = {
					enable = true,
				},
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader-m>",
						node_incremental = "<c-m>",
						scope_incremental = "<leader-n>",
						node_decremental = "<c-n>",
					},
				},
				-- textobjects = {
				-- 	select = {
				-- 		enable = true,
				-- 		lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				-- 		keymaps = {
				-- 			-- You can use the capture groups defined in textobjects.scm
				-- 			["aa"] = "@parameter.outer",
				-- 			["ia"] = "@parameter.inner",
				-- 			["af"] = "@function.outer",
				-- 			["if"] = "@function.inner",
				-- 			["ac"] = "@class.outer",
				-- 			["ic"] = "@class.inner",
				-- 		},
				-- 	},
				-- 	move = {
				-- 		enable = true,
				-- 		set_jumps = true, -- whether to set jumps in the jumplist
				-- 		goto_next_start = {
				-- 			["]m"] = "@function.outer",
				-- 			["]]"] = "@class.outer",
				-- 		},
				-- 		goto_next_end = {
				-- 			["]M"] = "@function.outer",
				-- 			["]["] = "@class.outer",
				-- 		},
				-- 		goto_previous_start = {
				-- 			["[m"] = "@function.outer",
				-- 			["[["] = "@class.outer",
				-- 		},
				-- 		goto_previous_end = {
				-- 			["[M"] = "@function.outer",
				-- 			["[]"] = "@class.outer",
				-- 		},
				-- 	},
				-- 	swap = {
				-- 		enable = true,
				-- 		swap_next = {
				-- 			["<leader>aa"] = "@parameter.inner",
				-- 		},
				-- 		swap_previous = {
				-- 			["<leader>AA"] = "@parameter.inner",
				-- 		},
				-- 	},
				-- },
			})
			-- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
			--
			-- -- Repeat movement with ; and ,
			-- -- ensure ; goes forward and , goes backward regardless of the last direction
			-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
			--
			-- -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
			-- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
			-- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
			-- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
			-- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
		end,
	},
}
