return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
			"AckslD/nvim-neoclip.lua",
		},
		-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		build = "make",
		event = "VeryLazy",
		config = function()
			require("telescope").load_extension("fzf")
			local open_with_trouble = require("trouble.sources.telescope").open

			require("telescope").setup({
				defaults = {
					path_display = { truncate = 3 },
					file_ignore_patterns = {
						"node_modules",
						"Publish",
						"bin",
						"obj",
						".nuget",
					},
					mappings = {
						i = { ["<c-t>"] = open_with_trouble },
						n = {
							["<c-t>"] = open_with_trouble,
							["x"] = require("telescope.actions").delete_buffer,
							["q"] = require("telescope.actions").close,
						},
					},
				},
				pickers = {
					current_buffer_fuzzy_find = {
						theme = "dropdown",
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
			vim.api.nvim_set_keymap(
				"n",
				"<leader>pF",
				"<cmd>lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('~') })<CR>",
				{ noremap = true, silent = true }
			)
			--vim.keymap.set("n", "<leader>po", builtin.current_buffer_fuzzy_find, {})
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[P] Fuzzily search in current buffer" })

			vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "[P] Fuzzily search in git files" })
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, { desc = "[P] Fuzzily search for word in files" })

			vim.keymap.set("n", "<leader>pws", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end, { desc = "[P] Fuzzily search for current word" })

			vim.keymap.set("n", "<leader>pWs", function()
				local word = vim.fn.expand("<cWORD>")
				builtin.grep_string({ search = word })
			end)

			require("nvim-treesitter.install").prefer_git = false
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			-- vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set(
				"n",
				"<leader>fb",
				-- Notice that I start it in normal mode to navigate similarly to bufexplorer,
				-- the ivy theme is also similar to bufexplorer and tmux sessions
				"<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>",
				{ desc = "[P]Open telescope buffers" }
			)

			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fk", "<CMD>Telescope keymaps<CR>")
			vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, {})
			--vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<CR>", { noremap = true, silent = true })

			vim.keymap.set("n", "<leader>dd", function()
				require("telescope.builtin").diagnostics({ severity_limit = 2 })
			end)

			vim.keymap.set("n", "<leader>ds", function()
				require("telescope.builtin").diagnostics({})
			end)

			vim.keymap.set("n", "<leader><space>", "<cmd>e #<cr>", { desc = "Alternate buffer" })

			vim.keymap.set(
				"n",
				"<leader>tl",
				"<cmd>TodoTelescope keywords=TODO<cr>",
				{ desc = "[P]TODO list (Telescope)" }
			)

			vim.keymap.set(
				"n",
				"<leader>ta",
				"<cmd>TodoTelescope keywords=PERF,HACK,TODO,NOTE,FIX<cr>",
				{ desc = "[P]TODO list ALL (Telescope)" }
			)

			vim.keymap.set(
				"n",
				"<leader>cn",
				"<cmd>:Telescope find_files cwd=~/.config/nvim<cr>",
				{ desc = "[P]Fuzzily search in ~/.config/nvim (Telescope)" }
			)

			require("neoclip").setup()
			vim.api.nvim_set_keymap("n", "<leader>pp", "<cmd>Telescope neoclip<CR>", { noremap = true, silent = true })
		end,
	},
}
