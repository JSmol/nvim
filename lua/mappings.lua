local wk = require('which-key')
wk.add({
  { '<leader>xx', '<CMD>source %<CR>',     desc = 'Run Current File' },
  { '<leader>tn', '<CMD>tabnew<CR>',       desc = 'New Tab' },
  { '<leader>\\', '<CMD>vsp<CR>',          desc = 'V Split' },
  { '<leader>-',  '<CMD>sp<CR>',           desc = 'H Split' },
  { '<leader>q',  '<CMD>bd<CR>',           desc = 'Kill Buffer' },
  { '<leader>w',  '<CMD>close<CR>',        desc = 'Close Window' },
  { '<leader>cj', '<CMD>cnext<CR>',        desc = 'Next QF Item' },
  { '<leader>ck', '<CMD>cprev<CR>',        desc = 'Prev QF Item' },
  { '<leader>a',  vim.lsp.buf.code_action, desc = 'Code Action' },
  { '<leader>rn', vim.lsp.buf.rename,      desc = 'Rename Symbol' },
})

wk.add({
  { '<leader>tp', '<CMD>r! cat ~/competitive/template.cc<CR>ggdd', desc = 'Copy Template' },
  { '<leader>in', '<CMD>e ./test.in<CR>',                   desc = 'Edit Test Input' },
  { '<leader>ga', '<CMD>e ~/competitive/algorithms<CR>',    desc = 'View Algorithms' },
  { '<leader>rr', '<CMD>! ~/competitive/run %<CR>',         desc = 'Run Script' },
})
