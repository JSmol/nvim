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

-- vim.api.nvim_set_option("clipboard", "unnamed")

require('ibl').setup()

-- THEME --
require('theme')

require('terminal')

require('lsp')
require('statusline')
require('keyboard')

-- hide line numbers in terminal windows --
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')
vim.opt.cursorline = true

