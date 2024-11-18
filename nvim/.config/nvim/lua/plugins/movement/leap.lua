return {
	"ggandor/leap.nvim",
	dependencies = {
		"tpope/vim-repeat",
	},
	event = "VeryLazy",
	config = function()
		vim.keymap.set({ "n", "x", "o" }, "<leader>s", "<Plug>(leap-forward)")
		vim.keymap.set({ "n", "x", "o" }, "<leader>S", "<Plug>(leap-backward)")
		vim.keymap.set({ "n", "x", "o" }, "<leader>gs", "<Plug>(leap-from-window)")

		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })

		require("leap").add_repeat_mappings(";", ",", {
			-- False by default. If set to true, the keys will work like the
			-- native semicolon/comma, i.e., forward/backward is understood in
			-- relation to the last motion.
			relative_directions = true,
			-- By default, all modes are included.
			modes = { "n", "x", "o" },
		})
	end,
}
