-- enter normal mode with esc in terminals --
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- hide line numbers in terminal windows --
-- vim.cmd('autocmd TermOfen * setlocal nonumber norelativenumber')
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('topen', { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end
})

local wk = require('which-key')
local tm = require('terminal-manager')
wk.add({ { '<leader>o', function() tm:toggle('Main', 'bash') end, desc = 'Main Terminal' } })
for i = 0, 9, 1 do
  wk.add({
    '<leader>tt' .. tostring(i),
    function() tm:toggle('Scratch ' .. tostring(i), 'bash') end,
    desc = 'Toggle Terminal' .. tostring(i),
    group = 'terminal'
  })
end

local jm = require('job-manager')
wk.add({
  group = 'JobManager',
  { '<leader>b',  function() jm:create('./build.sh') end, desc = 'Run `build.sh`' },
  { '<leader>jr', function() jm:listcmds() end,           desc = 'Run and Job' },
  { '<leader>jl', function() jm:listjobs() end,           desc = 'List Jobs' },
})
