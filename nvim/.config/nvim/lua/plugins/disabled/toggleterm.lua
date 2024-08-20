return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "float",
			shell = "bash.exe",
			open_mapping = [[<c-\>]],
		})
	end,
}
