return {
	"alexghergh/nvim-tmux-navigation",
	config = function()
		require("nvim-tmux-navigation").setup({
			keybindings = {
				left = "<M-h>",
				down = "<M-j>",
				up = "<M-k>",
				right = "<M-l>",
				last_active = "<M-\\>",
				next = "<M-Space>",
			},
		})
		local kopts = { noremap = true, silent = true }
		vim.keymap.set("i", "<M-h>", "<esc>:NvimTmuxNavigateLeft<cr>)", kopts)
		vim.keymap.set("i", "<M-j>", "<esc>:NvimTmuxNavigateDown<cr>)", kopts)
		vim.keymap.set("i", "<M-k>", "<esc>:NvimTmuxNavigateUp<cr>)", kopts)
		vim.keymap.set("i", "<M-l>", "<esc>:NvimTmuxNavigateRight<cr>)", kopts)
	end,
}
