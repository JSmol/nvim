-- WARNING: DANGER ZONE!
-- ISSUE: this code broken!
-- OPTIM: faster!
-- TODO: refactoring
-- NOTE: notes!
-- HACK: this code sucks!

-- general vim options & plugins --
vim.cmd 'runtime vimrc' 
require('plugins')

-- THEME --
require('theme')
vim.cmd[[colorscheme catppuccin]]

require('lsp')
require('statusline')
require('keyboard')
require('buffers')

require('scope')
require("comments")
require('terminal')

local g, opt, win = vim.g, vim.o, vim.wo
local cmd = vim.cmd

-- cmd("hi! StatusLine gui=underline guibg=NONE")
-- cmd("hi! StatusLineNC gui=underline guibg=NONE")

-- show indentation guides (indent blankline plugin) --
-- cmd("hi! StatusLineNC gui=underline guibg=NONE guifg=#383c44")
-- cmd("hi IndentBlanklineChar guifg=#2a2e36")
g.indentLine_enabled = 1
g.indent_blankline_char = "▏"
g.indent_blankline_filetype_exclude = {"help", "terminal"}
g.indent_blankline_buftype_exclude = {"terminal"}
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false

-- hide line numbers in terminal windows --
cmd('autocmd TermOpen * setlocal nonumber norelativenumber')

