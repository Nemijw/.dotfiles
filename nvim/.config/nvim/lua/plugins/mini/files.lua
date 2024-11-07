return {
	{
		"echasnovski/mini.files",
		version = false,
		event = "VeryLazy",
		config = function()
			local mini_files = require("mini.files")
			mini_files.setup()
			vim.keymap.set(
				"n",
				"<leader>-",
				"<CMD>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>",
				{ desc = "Open working directory" }
			)
			vim.keymap.set("n", "<leader>_", mini_files.open, { desc = "Open parent directory" })
		end,
	},
}
