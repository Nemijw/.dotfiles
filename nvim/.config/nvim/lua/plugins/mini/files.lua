return {
	{
		"echasnovski/mini.files",
		version = false,
		event = "VeryLazy",
		config = function()
			local mini_files = require("mini.files")
			mini_files.setup()
			vim.keymap.set("n", "<leader>-", mini_files.open, { desc = "Open parent directory" })
		end,
	},
}
