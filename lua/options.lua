vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_dirhistmax = 0

vim.opt.termguicolors = true
vim.opt.clipboard:append('unnamedplus')

vim.o.wrap = false
vim.o.hidden = true
vim.o.backup = false

vim.o.cursorline = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.ai = true
vim.o.si = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smarttab = true

vim.o.splitright = true
vim.o.splitbelow = true
