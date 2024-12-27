-- Standard options I almost always want.
require('options')

-- TODO: Maybe use this one day...
vim.g.editorconfig = false

-- bootstrap plugins --
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
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
  checker = { enabled = true },
  rocks = { enabled = false }
})

-- Fancy notificaiton system... I kind of like it...
vim.notify = require('notify')

-- General mappings for other stuff.
require('mappings')

-- Mappings and such relating to terminals and background jobs.
require('terminal')

-- Everytime we write we can clear all the empty bufs tbh.
-- It's pretty annoying to have 9001 [No Name] buffers after a while.
-- TODO: This but better.
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = {},
  callback = function()
    local function isempty(t)
      return #t == 0 or #t == 1 and t[1] == ''
    end
    local function isopen(buf)
      for _, win in pairs(vim.api.nvim_list_wins()) do
        if buf == vim.api.nvim_win_get_buf(win) then
          return true
        end
      end
      return false
    end
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in ipairs(bufs) do
      local txt = vim.api.nvim_buf_get_text(buf, 0, 0, -1, -1, {})
      local name = vim.api.nvim_buf_get_name(buf)
      if name == '' and isempty(txt) and not isopen(buf) then
        vim.api.nvim_buf_delete(buf, { force = false })
      end
    end
  end
})
