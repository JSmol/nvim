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

-- telescope --
map('<C-p>', '<CMD>Telescope find_files<CR>')
map('<leader>lg', '<CMD>Telescope live_grep<CR>')
map('<leader>he', '<CMD>Telescope help_tags<CR>')
map('<leader>ss', '<CMD>Telescope treesitter<CR>')
map('<leader>gs', '<CMD>Telescope git_status<CR>')
map('<leader>gt', '<CMD>Telescope git_stash<CR>')
map('<leader>gb', '<CMD>Telescope git_branches<CR>')

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
map('<C-n>', '<CMD>bnext<CR>')
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
map('<leader>al', '<CMD>Explore ~/Competitive/algorithms/<CR>')
map('<leader>in', '<CMD>e %:h/test.in<CR>')

-- run python file --
map('<leader>py', '<CMD>!python %<CR>')

