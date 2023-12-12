-- normal mode --
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap=true, silent=true }) -- enter normal mode with esc in terminals

-- hide line numbers in terminal windows --
vim.cmd('autocmd TermOpen * setlocal nonumber norelativenumber')

-- toggle terms --
local terms = {}
local prebuf = 0

-- window showing named terminal or nil
local function get_window(name)
    local wins = vim.api.nvim_list_wins()
    for i, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        if terms[name].buf == buf then
            return win
        end
    end
    return nil
end

-- create new terminal buffer
local function create_term(name)
    local curbuf = vim.api.nvim_get_current_buf()
    terms[name] = { buf = vim.api.nvim_create_buf(true, false) }
    vim.api.nvim_set_current_buf(terms[name].buf)
    terms[name].term = vim.fn.termopen('bash', {
        on_exit = function()
            terms[name] = nil
        end,
        on_stdout = function(id, data)
            if data then
                local curwin = vim.api.nvim_get_current_win()
                local win = get_window(name)
                -- print(curwin, win, data)
                if curwin ~= win then
                    local esckey = vim.api.nvim_replace_termcodes('<ESC>', true, true, true)
                    vim.api.nvim_set_current_win(win)
                    vim.cmd[[:normal G]]
                    vim.api.nvim_set_current_win(curwin)
                end
            end
        end
    })
    -- return to the old buffer, in case the command should just run in background
    -- TODO: is there a better way to do this whole thing?
    vim.api.nvim_set_current_buf(curbuf)
end

-- open the term in a split or full screen
local function open_term(name, focus, split_height)
    local curbuf = vim.api.nvim_get_current_buf()
    local curwin = vim.api.nvim_get_current_win()
    if split_height then
        vim.cmd[[botright split]]
        vim.api.nvim_set_current_buf(terms[name].buf)
        vim.api.nvim_win_set_height(0, split_height)
        if focus then
            vim.cmd('startinsert')
        else
            -- otherwise set win back to curwin
            vim.api.nvim_set_current_win(curwin)
        end
    else
        if focus then
            vim.api.nvim_set_current_buf(terms[name].buf)
            vim.cmd('startinsert')
        end
    end
end

-- run a command in a named terminal --
local function run(name, cmd, focus, split_height)
    -- focus true by default makes sense.
    if focus == nil then focus = true end
    local curbuf = vim.api.nvim_get_current_buf()
    -- create the term if it does not exist
    if not terms[name] then
        create_term(name)
    end
    -- if the terminal is not open in a window
    if get_window(name) == nil then
        open_term(name, focus, split_height)
    end
    -- send the cmd --
    vim.api.nvim_chan_send(
        terms[name].term,
        cmd .. vim.api.nvim_replace_termcodes('<CR>', true, true, true)
    )
end

local function toggle_term(name)
    local curbuf = vim.api.nvim_get_current_buf()
    if not terms[name] then
        create_term(name)
    end
    if terms[name].buf == curbuf then
        vim.api.nvim_set_current_buf(prebuf)
    else
        prebuf = curbuf
        vim.api.nvim_set_current_buf(terms[name].buf)
        vim.cmd('startinsert')
    end
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

local wk = require('which-key')

wk.register({
    ['<leader>o'] = { function() toggle_term('main') end, 'Toggle Term' },
    ['<leader>b'] = { function() run('build', './build.sh') end, 'Run `build.sh`' },
    ['<leader>rt'] = { function() run('tcomp', './run.sh ' .. vim.fn.expand('%'), false, 12) end, 'Run `run.sh %`' },
    ['<leader>ipy'] = { function() run('ipython', 'ipython', true, 12) end, 'Open IPython' },
    ['<leader>hsi'] = { function() run('ghci', 'ghci', true, 12) end, 'Open GHCI' },
    ['<leader>hsl'] = { function() run('ghci', ':load ' .. vim.fn.expand('%'), true, 12) end, ':load %' },
    ['<leader>hsr'] = { function() run('ghci', vim.fn.expand('<cword>'), true, 12) end, 'Run function under cursor' },
})

-- TODO:
-- wk.register({
--     ['<leader>rp'] = { function() run('ipython', 'ipython', 12, true) end, 'Send visual sel to IPython', mode = v },
-- })

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

