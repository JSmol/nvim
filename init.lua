-- WARNING: DANGER ZONE!
-- ISSUE: this code broken!
-- OPTIM: faster!
-- TODO: refactoring
-- NOTE: notes!
-- HACK: this code sucks!

-- general vim options & plugins --
vim.cmd 'runtime vimrc'

-- plugins --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require('plugins')

require("nvim-treesitter.configs").setup({
  ensure_installed = { "markdown", "markdown_inline", ... },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" },
  },
})

-- terminal --
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap=true, silent=true }) -- enter normal mode with esc in terminals

-- vim.api.nvim_set_option("clipboard", "unnamed")

-- indentation guides --
require('ibl').setup()

-- THEME --
require('theme')

require('terminal')

require('lsp')
require('keyboard')
require('statusline')

-- hide line numbers in terminal windows --
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')
vim.opt.cursorline = true

