return {
	{
		-- Buffer 				[B [b ]b ]B
		-- Comment block 		[C [c ]c ]C
		-- Conflict marker 	    [X [x ]x ]X
		-- Diagnostic			[D [d ]d ]D
		-- File on disk		    [F [f ]f ]F
		-- Indent change		[I [i ]i ]I
		-- Old files			[O [o ]o ]O
		-- Jump from jumplist inside current buffer 			[J [j ]j ]J
		-- Location from location list							[L [l ]l ]L
		-- Quickfix entry from quickfix list 					[Q [q ]q ]Q
		-- Tree-sitter node and parents						    [T [t ]t ]T
		-- Undo states from specially tracked linear history 	[U [u ]u ]U
		-- Window in current tab 								[W [w ]w ]W
		-- Yank selection replacing latest put region 			[Y [y ]y ]Y
		"echasnovski/mini.bracketed",
		version = false,
		event = "VeryLazy",
		config = true,
	},
}
