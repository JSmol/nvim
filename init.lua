-- general vim options & plugins --
vim.cmd('runtime vimrc')
vim.g.editorconfig = false

-- bootstrap plugins --
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--branch=stable',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = { { import = 'plugins' } },
  install = { colorscheme = { 'catppuccin' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.cmd('colorscheme catppuccin')
require('mappings')
require('terminal')
require('debugger')
-- require('lsp')
-- require('gdb')
-- require('statusline')

