return {
	{ "folke/twilight.nvim" },
	{
		"folke/zen-mode.nvim",
		event = "VeryLazy",
		config = function()
			require("zen-mode").setup({
				plugins = {
					tmux = {
						enabled = true,
					},
				},
			})
			vim.keymap.set("n", "<leader>zm", require("zen-mode").toggle)
		end,
	},
}
