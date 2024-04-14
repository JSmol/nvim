-- enter normal mode with esc in terminals --
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap=true, silent=true })

-- hide line numbers in terminal windows --
-- vim.cmd('autocmd TermOpen * setlocal number relativenumber')

-- toggle terms --
local terms = {}
local prebuf = 0

local function update_cwd(name)
  local tmpfn = '/tmp/termcwd' .. terms[name].term
  vim.api.nvim_chan_send(
    terms[name].term,
    vim.api.nvim_replace_termcodes('<C-u>', true, true, true)
  )
  vim.api.nvim_chan_send(
    terms[name].term,
    'pwd > ' .. tmpfn .. vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  )
  vim.api.nvim_chan_send(
    terms[name].term,
    vim.api.nvim_replace_termcodes('<C-l>', true, true, true)
  )
  vim.cmd('sleep 100m')
  terms.cwd = vim.fn.readfile(tmpfn)[1]
end

-- create new terminal buffer and tab
local function create_term(name)
  vim.cmd('tabnew')
  vim.cmd('LualineRenameTab ' .. name)
  local curbuf = vim.api.nvim_get_current_buf()
  terms[name] = {
    buf = vim.api.nvim_create_buf(true, false),
    cwd = vim.fn.getcwd()
  }
  vim.api.nvim_set_current_buf(terms[name].buf)
  terms[name].term = vim.fn.termopen('bash', {
    on_exit = function()
      terms[name] = nil
    end,
    on_stdout = function(id, data)
    end
  })
  vim.api.nvim_set_current_buf(curbuf)
end

-- focus window for term name if it exists
local function focus_win(name)
  local wins = vim.api.nvim_list_wins()
  for i, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    if terms[name].buf == buf then
      vim.api.nvim_set_current_win(win)
      return true
    end
  end
  return false
end

-- open the term
local function open_term(name)
  if not focus_win(name) then
    vim.api.nvim_set_current_buf(terms[name].buf)
  end
end

-- run a command in a named terminal --
local function run(name, cmd)
  if not terms[name] then
    create_term(name)
  end
  open_term(name)
  vim.api.nvim_chan_send(
    terms[name].term,
    cmd .. vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  )
end

local function toggle_term(name)
  if not terms[name] then
    create_term(name)
  end
  open_term(name)
end

-- reload current .hs file into ghci on write (if ghci is open) --
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('haskell', { clear = true }),
    pattern = '*.hs',
    callback = function()
        if terms['ghci'] then
            run('ghci', ':load ' .. vim.fn.expand('%'), true, 12)
        end
    end
})

-- TODO: aucmd for ipython and .py files
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('ipython', { clear = true }),
    pattern = '*.py',
    callback = function()
        local cr = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
        if terms['ipython'] then
            run('ipython', '%load ' .. vim.fn.expand('%') .. cr, true, 12)
        end
    end
})

-- telescope search in directory --
local function find_here()
    local builtin = require('telescope.builtin')
    local buffer = vim.api.nvim_get_current_buf()
    for name in pairs(terms) do
        if terms[name].buf == buffer then
            update_cwd(name)
            local cwd = terms[name].cwd
            builtin.find_files({ cwd = cwd })
            return
        end
    end
    local path = vim.fn.expand('%:p:h')
    builtin.find_files({ cwd = path })
end

local wk = require('which-key')
wk.register({
    ['<leader>o'] = { function() toggle_term('MAIN') end, 'Toggle Term' },
    ['<leader>b'] = { function() run('BUILD', './build.sh ' .. vim.fn.expand('%')) end, 'Run `build.sh`' },
    ['<leader>fh'] = { find_here, 'Find Files Here' },
})

wk.register({
    ['<leader>i'] = {
        name = '+interactive',
        ['py'] = { function() run('IPYTHON', 'ipython', 12, true) end, 'Send visual sel to IPython', mode = v },
        ['hs'] = { function() run('GHCI', 'ghci', true, 12) end, 'Open GHCI' },
        ['hsl'] = { function() run('GHCI', ':load ' .. vim.fn.expand('%'), true, 12) end, ':load %' },
        ['hsr'] = { function() run('GHCI', vim.fn.expand('<cword>'), true, 12) end, 'Run function under cursor' },
    },
})

wk.register({
    ['<leeader>d'] = {
        name = '+debug',
        d = { function() toggle_term('DEBUG') end, 'Toggle Debug Terminal' },

    }
})

wk.register({
    ['<leader>sh1'] = { function() toggle_term('scratch1') end, 'Toggle Scratch 1' },
    ['<leader>sh2'] = { function() toggle_term('scratch2') end, 'Toggle Scratch 2' },
    ['<leader>sh3'] = { function() toggle_term('scratch3') end, 'Toggle Scratch 3' },
    ['<leader>sh4'] = { function() toggle_term('scratch4') end, 'Toggle Scratch 4' },
    ['<leader>sh5'] = { function() toggle_term('scratch5') end, 'Toggle Scratch 5' },
    ['<leader>sh6'] = { function() toggle_term('scratch6') end, 'Toggle Scratch 6' },
    ['<leader>sh7'] = { function() toggle_term('scratch7') end, 'Toggle Scratch 7' },
    ['<leader>sh8'] = { function() toggle_term('scratch8') end, 'Toggle Scratch 8' },
    ['<leader>sh9'] = { function() toggle_term('scratch9') end, 'Toggle Scratch 9' },
    ['<leader>sh0'] = { function() toggle_term('scratch0') end, 'Toggle Scratch 0' },
})

wk.register({
    ['<leader>cb'] = { function() run('rust', 'cargo build') end, 'cargo build' },
    ['<leader>cr'] = { function() run('rust', 'cargo run', false, 12) end, 'cargo run' },
    ['<leader>nb'] = { function() run('nb', 'npm run build') end, 'npm run build' },
    ['<leader>nw'] = { function() run('nw', 'npm run watch', false) end, 'npm run watch' },
    ['<leader>ns'] = { function() run('ns', 'npm run serve', false) end, 'npm run serve' },
})

