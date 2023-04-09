-- Line numbers
vim.opt.number = true

-- Tabs and Indent
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true

-- Text Wrapping
vim.opt.wrap = false

-- Vim Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Colours
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- Backspace behaviour
vim.opt.backspace = "indent,eol,start"

-- Clipboard
vim.opt.clipboard:append("unnamedplus")

-- Window Splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- NetRW
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Completions
vim.opt.completeopt = "menu,menuone,noinsert"

-- Map leader binds
vim.g.mapleader = ' '
