return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		-- {
		-- 	"<leader>xx",
		-- 	"<cmd>Trouble diagnostics toggle<cr>",
		-- 	desc = "Diagnostics (Trouble)",
		-- },
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>vrr",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xl",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xq",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
		{
			"<leader>xt",
			"<cmd>Trouble telescope toggle<cr>",
			desc = "Telescope List (Trouble)",
		},
	},
	opts = {
		-- vim.keymap.set("n", "<leader>xx", function()
		-- 	require("trouble").toggle()
		-- end),
		-- vim.keymap.set("n", "<leader>xw", function()
		-- 	require("trouble").open("workspace_diagnostics")
		-- end),
		-- vim.keymap.set("n", "<leader>xd", function()
		-- 	require("trouble").open("document_diagnostics")
		-- end),
		-- vim.keymap.set("n", "<leader>xq", function()
		-- 	require("trouble").open("quickfix")
		-- end),
		-- vim.keymap.set("n", "<leader>xl", function()
		-- 	require("trouble").open("loclist")
		-- end),
		-- vim.keymap.set("n", "<leader>vrr", function()
		-- 	require("trouble").open("lsp_references")
		-- end),
		vim.keymap.set("n", "<C-k>", function()
			require("trouble").next({ skip_groups = true, jump = true })
		end),
		vim.keymap.set("n", "<C-j>", function()
			require("trouble").prev({ skip_groups = true, jump = true })
		end),
		vim.keymap.set("n", "<C-h>", function()
			require("trouble").first({ skip_groups = true, jump = true })
		end),
		vim.keymap.set("n", "<C-l>", function()
			require("trouble").last({ skip_groups = true, jump = true })
		end),
	},
}
