return {
	{
		--comment with gc in v and gcc in n
		"echasnovski/mini.comment",
		version = false,
		event = "VeryLazy",
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			require("mini.comment").setup({
				options = {
					custom_commentstring = function()
						return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
					end,
				},
			})
		end,
	},
}
