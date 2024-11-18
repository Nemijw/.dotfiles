return {
	{
		-- Main textobject prefixes
		--    around = 'a',
		--    inside = 'i',
		--
		--    -- Next/last variants
		--    around_next = 'an',
		--    inside_next = 'in',
		--    around_last = 'al',
		--    inside_last = 'il',
		"echasnovski/mini.pairs",
		version = false,
		config = true,
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
	},
}
