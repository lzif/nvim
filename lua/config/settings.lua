vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.numberwidth = 2
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Wrapping
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.linebreak = true

-- Tabs & Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Files
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false

-- Performance
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

-- Split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Clipboard (sync dengan system clipboard)
vim.opt.clipboard = "unnamedplus"

vim.filetype.add({
	extension = {
		svelte = "svelte",
	},
})
