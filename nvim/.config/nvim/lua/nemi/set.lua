vim.opt.nu = true
vim.opt.relativenumber = true
--vim.opt.shellslash = false
--vim.o.cmdheight = 0
---linenumbers for netrw
vim.g.netrw_bufsettings = "noma nomod nu rnu nobl nowrap ro"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

--vim.api.nvim_parse_cmd = true
--vim.opt.hlsearch = false
--vim.opt.incsearch = true

vim.g.mouse = a

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.cmd([[command! Q :q]])
vim.cmd([[command! W :w]])
vim.cmd([[command! Wq :wq]])
vim.cmd([[command! WQ :wq]])

vim.diagnostic.config({
	virtual_text = false,
})

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.opt.path:append("**")

vim.opt.wildignore:remove({ "node_modules" })

vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })

vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"
vim.opt.grepformat = "%f:%l:%c:%m"
