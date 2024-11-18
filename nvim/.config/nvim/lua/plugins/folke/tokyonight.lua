return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			transparent = true,
			--tokyonight_dark_float = false,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		})
	end,
}
