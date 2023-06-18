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
map('<leader>sh', '<CMD>term<CR>i')
map('<leader>sa', '<CMD>term sage<CR>i')

-- they changed Y to y$ for reasons --
map('Y', 'yy', 'n')

-- toggler nvim tree --
map('<C-d>', '<CMD>NvimTreeToggle<CR>')

-- z e n m o d e --
map('<leader>z', '<CMD>ZenMode<CR>')

-- manage buffers / screens --
map('<C-n>', '<CMD>bnext<CR>')
map('<leader>w', '<CMD>close<CR>')
map('<leader>q', '<CMD>bd<CR>')

-- fzfind key --
map('<C-p>', '<CMD>Telescope find_files<CR>')

-- open config files --
map('<leader>kb', '<CMD>e ~/.config/nvim/lua/keyboard.lua<CR>')
map('<leader>vc', '<CMD>e ~/.config/nvim/vimrc<CR>')
map('<leader>nc', '<CMD>e ~/.config/nvim/init.lua<CR>')
map('<leader>rc', '<CMD>e ~/.bashrc<CR>')

-- competitive programming shortcuts --
map('<F10>', '<CMD>term ~/Competitive/run %<CR>i')
map('<leader>sk', '<CMD>term python3 ~/Competitive/submit.py %<CR>i')
map('<leader>tp', '<CMD>r ~/Competitive/template.cc<CR>ggdd')
map('<leader>al', '<CMD>Explore ~/Competitive/algorithms/<CR>')
map('<leader>in', '<CMD>e %:h/test.in<CR>')
map('<leader>run', '<CMD>e ~/Competitive/run<CR>')

-- python --
-- map('<leader>py', '<CMD>!python %<CR>')

-- rust --
-- map('<leader>cr', '<CMD>TermExec cmd="cargo run"<CR>')
-- map('<leader>cf', '<CMD>TermExec cmd="cargo fmt"<CR>')
-- map('<leader>cwa', '<CMD>TermExec cmd="wasm-pack build"<CR>')

-- NPM/JS --
-- map('<leader>nb', '<CMD>TermExec cmd="npm run build"<CR>')
-- map('<leader>ns', '<CMD>TermExec cmd="npm run serve"<CR>')

