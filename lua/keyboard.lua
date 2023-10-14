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

-- terminal --
map('<Esc>', '<C-\\><C-n>', 't') -- enter normal mode with esc in terminals

map('<leader>sf', '<CMD>w<CR>')

-- map('<leader>d', '<CMD>e ~/.config/nvim/readme.md<CR>')

-- z e n m o d e --
map('<leader>z', '<CMD>ZenMode<CR>')

-- panes --
map('<leader>\\', '<CMD>vsp<CR>')
map('<leader>-', '<CMD>sp<CR>')
map('<leader>kk', '<CMD>wincmd k<CR><ESC>')
map('<leader>jj', '<CMD>wincmd j<CR><ESC>')
map('<leader>hh', '<CMD>wincmd h<CR><ESC>')
map('<leader>ll', '<CMD>wincmd l<CR><ESC>')

-- telescope --
map('<leader>p', '<CMD>Telescope find_files<CR>')
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

-- mo folds mo problems --
map('<leader>fz', 'za')
map('<leader>fa', '<CMD>set foldlevel=0<CR>')
map('<leader>fs', '<CMD>set foldlevel=99<CR>')
map('<leader>f1', '<CMD>set foldlevel=1<CR>')
map('<leader>f2', '<CMD>set foldlevel=2<CR>')
map('<leader>f3', '<CMD>set foldlevel=3<CR>')
map('<leader>f4', '<CMD>set foldlevel=4<CR>')
map('<leader>f5', '<CMD>set foldlevel=5<CR>')

-- manage buffers / screens --
map('<leader>w', '<CMD>close<CR>')
map('<leader>q', '<CMD>bd<CR>')

-- open config files --
map('<leader>kb', '<CMD>e ~/.config/nvim/lua/keyboard.lua<CR>')
map('<leader>nv', '<CMD>e ~/.config/nvim/readme.md<CR>')

-- competitive programming shortcuts --
map('<leader>sk', '<CMD>term python ~/projects/kattis-cli/submit.py %<CR>i')
map('<leader>tp', '<CMD>r ~/codeforces/template.cc<CR>ggdd')
map('<leader>in', '<CMD>e %:h/test.in<CR>')

