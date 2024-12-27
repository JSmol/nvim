local wk = require('which-key')

wk.add({
  { '<leader>xx', '<CMD>source %<CR>', desc = 'Run Current File' },
  { '<leader>tn', '<CMD>tabnew<CR>',   desc = 'New Tab' },
  { '<leader>\\', '<CMD>vsp<CR>',      desc = 'V Split' },
  { '<leader>-',  '<CMD>sp<CR>',       desc = 'H Split' },
  { '<leader>q',  '<CMD>bd<CR>',       desc = 'Kill Buffer' },
  { '<leader>w',  '<CMD>close<CR>',    desc = 'Close Window' },
  { '<leader>cj', '<CMD>cnext<CR>',    desc = 'Next QF Item' },
  { '<leader>ck', '<CMD>cprev<CR>',    desc = 'Prev QF Item' },
})

for i = 0, 9, 1 do
  wk.add({ '<leader>' .. tostring(i), tostring(i) .. 'gt', desc = 'Goto Tab' });
end

wk.add({
  group = 'search',
  { '<leader>p',  '<CMD>Telescope find_files<CR>',          desc = 'Find Files' },
  { '<leader>st', '<CMD>TodoTelescope<CR>',                 desc = 'Search TODO' },
  { '<leader>sg', '<CMD>Telescope live_grep<CR>',           desc = 'Search Grep' },
  { '<leader>sb', '<CMD>Telescope buffers<CR>',             desc = 'Search Buffers' },
  { '<leader>sh', '<CMD>Telescope help_tags<CR>',           desc = 'Search Help' },
  { '<leader>ss', '<CMD>Telescope treesitter<CR>',          desc = 'Search Symbols' },
  { '<leader>gr', '<CMD>Telescope lsp_references<CR>',      desc = 'GOTO References' },
  { '<leader>gd', '<CMD>Telescope lsp_definitions<CR>',     desc = 'GOTO Definitions' },
  { '<leader>gi', '<CMD>Telescope lsp_implementations<CR>', desc = 'GOTO Implementations' },
})

wk.add({
  group = 'git',
  { '<leader>gts', '<CMD>Telescope git_status<CR>',         desc = 'Git Status' },
  { '<leader>gtb', '<CMD>Telescope git_branches<CR>',       desc = 'Git Branches' },
  { '<leader>gtd', '<CMD>DiffviewOpen<CR>',                 desc = 'Git Diff View' },
  { '<leader>gta', '<CMD>Gitsigns stage_buffer<CR>',        desc = 'Git Stage Buffer' },
  { '<leader>gtp', '<CMD>Gitsigns preview_hunk_inline<CR>', desc = 'Git Preview Hunk' },
})
