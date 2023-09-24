-- map keys helper --
local function map(lhs, rhs, mode)
  mode = mode or ''
  vim.api.nvim_set_keymap(
    mode,
    lhs,
    rhs,
    {noremap=true, silent=true}
  )
end

-- they changed Y to y$ for reasons --
map('Y', 'yy', 'n')

-- random tings --
map('<leader>fp', 'gF', 'n')

-- telescope --
map('<C-p>', '<CMD>Telescope find_files<CR>')
map('<leader>ls', '<CMD>Telescope buffers<CR>')
map('<leader>lg', '<CMD>Telescope live_grep<CR>')
map('<leader>he', '<CMD>Telescope help_tags<CR>')
map('<leader>ss', '<CMD>Telescope treesitter<CR>')
map('<leader>gs', '<CMD>Telescope git_status<CR>')
map('<leader>gt', '<CMD>Telescope git_stash<CR>')
map('<leader>gb', '<CMD>Telescope git_branches<CR>')

-- better marks --
local grapple = require("grapple")
map('<leader>m', '<CMD>GrappleToggle<CR>')
map('<leader>e', '<CMD>GrapplePopup tags<CR>')
map('<C-n>', '<CMD>GrappleCycle forward<CR>')
vim.keymap.set('n', '<leader>1', function() grapple.select({ key = 1 }) end)
vim.keymap.set('n', '<leader>2', function() grapple.select({ key = 2 }) end)
vim.keymap.set('n', '<leader>3', function() grapple.select({ key = 3 }) end)
vim.keymap.set('n', '<leader>4', function() grapple.select({ key = 4 }) end)
vim.keymap.set('n', '<leader>5', function() grapple.select({ key = 5 }) end)
vim.keymap.set('n', '<leader>6', function() grapple.select({ key = 6 }) end)
vim.keymap.set('n', '<leader>7', function() grapple.select({ key = 7 }) end)
vim.keymap.set('n', '<leader>8', function() grapple.select({ key = 8 }) end)
vim.keymap.set('n', '<leader>9', function() grapple.select({ key = 9 }) end)
vim.keymap.set('n', '<leader>0', function() grapple.select({ key = 10}) end)

-- terminal --
map('<Esc>', '<C-\\><C-n>', 't') -- enter normal mode with esc in terminals
map('<leader>sh', '<CMD>term<CR>i')

-- z e n m o d e --
map('<leader>z', '<CMD>ZenMode<CR>')

-- folds --
map('<leader>fz', 'za')
map('<leader>fa', '<CMD>set foldlevel=0<CR>')
map('<leader>fs', '<CMD>set foldlevel=99<CR>')

-- manage buffers / screens --
map('<leader>w', '<CMD>close<CR>')
map('<leader>q', '<CMD>bd<CR>')

-- open config files --
map('<leader>kb', '<CMD>e ~/.config/nvim/lua/keyboard.lua<CR>')
map('<leader>nc', '<CMD>e ~/.config/nvim/init.lua<CR>')
map('<leader>vc', '<CMD>e ~/.config/nvim/vimrc<CR>')

-- competitive programming shortcuts --
map('<F10>', '<CMD>term ~/Competitive/run %<CR>i')
map('<leader>sk', '<CMD>term python3 ~/Competitive/submit.py %<CR>i')
map('<leader>tp', '<CMD>r ~/Competitive/template.cc<CR>ggdd')
map('<leader>in', '<CMD>e %:h/test.in<CR>')

-- run python file --
map('<leader>py', '<CMD>!python %<CR>')

