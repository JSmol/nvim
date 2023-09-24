-- WARNING: DANGER ZONE!
-- ISSUE: this code broken!
-- OPTIM: faster!
-- TODO: refactoring
-- NOTE: notes!
-- HACK: this code sucks!

-- general vim options & plugins --
vim.cmd 'runtime vimrc' 
require('plugins')

vim.api.nvim_set_option("clipboard", "unnamed")

require('indent_blankline').setup({
  char = '│',
  space_char_blankline = ' ',
  filetype_exclude = { 'help', 'packer' },
  buftype_exclude = { 'terminal', 'nofile' },
})

-- THEME --
require('theme')
vim.cmd[[colorscheme catppuccin]]

require('terminal')

require('lsp')
require('statusline')
require('keyboard')


-- hide line numbers in terminal windows --
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')
vim.opt.cursorline = true
