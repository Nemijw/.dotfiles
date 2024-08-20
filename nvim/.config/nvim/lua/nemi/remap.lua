local set = vim.keymap.set

set("n", "<leader>pv", vim.cmd.Ex)

--do not save empty lines to register when deleting with dd.
set("n", "dd", function()
	if vim.fn.getline(".") == "" then
		return '"_dd'
	end
	return "dd"
end, { expr = true })
--vim.opt.shell = "bash.exe"

set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

set("n", "<leader>gi", "`^")

set("n", "<leader>bd", "<cmd>%bd|e#|bd#<CR>")

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")
--Semicolon at end and back to previous location.
set("n", "<leader>;", "mzA;<C-c>`z")
--normal movement in insert
-- set("i", "<C-h>", "<C-o>h")
-- set("i", "<C-h>", "<Left>")
-- set("i", "<C-j>", "<Down>")
-- set("i", "<C-k>", "<Up>")
-- set("i", "<C-l>", "<Right>")
-- set("i", "<C-w>", "<C-o>w")
-- set("i", "<C-b>", "<C-o>b")
-- set("i", "<C-d>", "<C-o>diw")
--Switch window with ctrl-h and ctrl-l
-- set("n", "<C-h>", "<C-w>W")
-- set("n", "<C-l>", "<C-w>w")
--enter changes current word.
-- set("n", "<cr>", "ciw")

--scroll right<>left
set("n", "<leader>zl", "zL")
set("n", "<leader>zh", "zH")
--set("n", "<leader>vwm", function()
--	require("vim-with-me").StartVimWithMe()
--end)
--set("n", "<leader>svwm", function()
--	require("vim-with-me").StopVimWithMe()
--end)

-- greatest remap ever
-- set("x", "<leader>p", [["*P]])
set("x", "<leader>p", '"_dP')

-- next greatest remap ever : asbjornHaland

set({ "n", "v" }, "<leader>y", '"+y')
set("n", "<leader>Y", '"+y')

--copy to clipboard windows.
-- set({ "n", "v" }, "<leader>y", [["*y]])
-- set("n", "<leader>Y", [["*Y]])

--set("n", "<leader>yp", "<cmd>let @+ = expand("")<CR>")

set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
set("i", "<C-c>", "<Esc>")
vim.o.timeoutlen = 500
set("i", "kj", "<Esc>")
set("i", "jk", "<Esc>")

set("n", "<leader>Q", "<nop>")
--set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- set("n", "<leader>f", vim.lsp.buf.format)

-- set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- set("n", "<leader>j", "<cmd>lprev<CR>zz")

set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")
--set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

set("n", "<F5>", function()
	vim.diagnostic.setloclist()
end)
set("n", "<F6>", function()
	vim.diagnostic.setqflist()
end)

set("n", "<leader>va", "ggVG")
--set("n", "<C-q>", "i<C-r>0<C-c>")

vim.api.nvim_set_keymap("n", "<leader>rmc", ":'<,'>s/\\/\\/\\s*//<CR>", { noremap = true })

set("n", "<leader>maw", "<C-w>_<C-w>|")
set("n", "<leader>mae", "<C-w>=")
set("n", "<leader>term", "<cmd>tabnew Terminal<CR><cmd>terminal<CR>icd<CR>")

set("n", "<leader>admind", "ggd4jVGpGo<CR>")
set("n", "<leader>wsb", "<cmd>windo set scb!<CR>")
set("n", "<leader>wd", "<cmd>w !diff % -<CR>")

--Pressing < or > will let you indent/unident selected lines
set("v", "<", "<gv")
set("v", ">", ">gv")

-- create new lines in Normal mode
set("n", "<leader>o", "o<Esc>^Da<Esc>k", { desc = "Newline Below", silent = true })
set("n", "<leader>O", "O<Esc>^Da<Esc>j", { desc = "Newline Above", silent = true })

--cd to current dir locally for buffer.
set("n", "<leader>lcd", "<cmd>lcd %:h<CR>", { silent = true })

--make .bak file
set("n", "<leader>bak", "<cmd>!cp % %.bak<CR>")

vim.api.nvim_set_keymap("n", "<Leader>rs", "<Cmd>noh<CR>", { desc = "Removes search", noremap = true, silent = true })

function log_word_under_cursor()
	local word = vim.fn.expand("<cword>")
	vim.fn.setreg("a", word)
	vim.api.nvim_input("oconsole.log('<C-R>a:', <C-R>a);<Esc>")
end

vim.api.nvim_set_keymap(
	"n",
	"<leader>L",
	[[:lua log_word_under_cursor()<CR>]],
	{ noremap = true, silent = true, desc = "log word under cursor" }
)
