return {
	"mistricky/codesnap.nvim",
	build = "make",
	config = function()
		require("codesnap").setup({
			save_path = "~/temp/codesnap/",
		})
	end,
}
