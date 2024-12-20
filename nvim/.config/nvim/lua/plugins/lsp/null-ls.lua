return {
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")

			null_ls.setup({
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format()
							end,
						})
					end
				end,
				sources = {
					null_ls.builtins.formatting.stylua,
					--null_ls.builtins.formatting.CSharpier,
					null_ls.builtins.formatting.yamlfmt,
					-- null_ls.builtins.diagnostics.eslint_d,
					-- null_ls.builtins.code_actions.eslint_d,
					null_ls.builtins.formatting.prettierd,
				},
			})
		end,
	},
}
