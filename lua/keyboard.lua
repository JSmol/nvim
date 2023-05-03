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

-- manage buffers / screens --
map('<C-n>', '<CMD>BufferLineCycleNext<CR>')
map('<leader>w', '<CMD>close<CR>')
map('<leader>q', '<CMD>bd<CR>')
map('<leader>o', '<CMD>only<CR>')

-- terminal --
map('<Esc>', '<C-\\><C-n>', 't')
map('<leader>sh', '<CMD>term<CR>i')
map('<leader>sa', '<CMD>term sage<CR>i')

-- fzfind key --
map('<C-p>', '<CMD>Telescope find_files<CR>')
map('<leader>b', '<CMD>Telescope buffers<CR>')
map('<leader>he', '<CMD>Telescope help_tags<CR>')

-- configs --
map('<leader>kb', '<CMD>e ~/.config/nvim/lua/keyboard.lua<CR>', 'n')
map('<leader>vc', '<CMD>e ~/.config/nvim/vimrc<CR>', 'n')
map('<leader>nc', '<CMD>e ~/.config/nvim/init.lua<CR>', 'n')
map('<leader>fc', '<CMD>e ~/.config/fish/config.fish<CR>', 'n')

-- run --
map('<leader>r', '<CMD>! %<CR>', 'n')

-- competitive programming shortcuts --
map('<F10>', '<CMD>term ~/Competitive/run %<CR>i', 'n')
map('<leader>sk', '<CMD>term python3 ~/Competitive/submit.py %<CR>i', 'n')
map('<leader>tp', '<CMD>r ~/Competitive/template.cc<CR>ggdd', 'n')
map('<leader>al', '<CMD>Explore ~/Competitive/algorithms/<CR>', 'n')
map('<leader>in', '<CMD>e %:h/test.in<CR>', 'n')
map('<leader>run', '<CMD>e ~/Competitive/run<CR>', 'n')

-- python scripts --
-- map('<leader>ipy', '<CMD>TermExec cmd="python %"<CR>', 'n')
map('<leader>py', '<CMD>TermExec cmd="python %"<CR>', 'n')
map('<leader>ma', '<CMD>TermExec cmd="manim -pql %"<CR>', 'n')

-- fish scripts --
map('<leader>fi', '<CMD>TermExec cmd="source %"<CR>', 'n')

-- rust --
map('<leader>cr', '<CMD>! cargo run<CR>', 'n')

