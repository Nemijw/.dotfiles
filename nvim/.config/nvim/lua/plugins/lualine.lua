return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"Isrothy/lualine-diagnostic-message",
		},
		event = "VeryLazy",
		config = function()
			local function diff_source()
				local gitsigns = vim.b.gitsigns_status_dict
				if gitsigns then
					return {
						added = gitsigns.added,
						modified = gitsigns.changed,
						removed = gitsigns.removed,
					}
				end
			end

			local function buffer_count()
				return tostring(#vim.fn.getbufinfo({ buflisted = 1 }))
			end

			require("lualine").setup({
				options = {
					theme = "tokyonight",
				},
				sections = {
					lualine_b = { { buffer_count }, { "filename", path = 4 }, { "diff", source = diff_source } },
					lualine_c = {
						{
							"diagnostic-message", --- If you want to custoimze the colors
							colors = {
								error = "#BF616A",
								warn = "#EBCB8B",
								info = "#A3BE8C",
								hint = "#88C0D0",
							},
							--- If you want to custoimze the icons
							icons = {
								error = "E",
								warn = "W",
								info = "I",
								hint = "H",
							},
						},
					},
					lualine_x = {
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							color = { fg = "#ff9e64" },
						},
					},
					-- lualine_y = { "tabs", { "b:gitsigns_head", icon = "" }, "progress" },
					lualine_y = { "selectioncount", "searchcount", "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
