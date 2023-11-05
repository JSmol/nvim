-- toggle term --
local terms = {}
local prebuf = 0

local function create_term(name)
    terms[name] = {}
    terms[name].buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_set_current_buf(terms[name].buf)
    terms[name].term = vim.fn.termopen('bash', {
        on_exit = function()
            terms[name] = nil
        end
    })
end

local function toggle_term(name)
    local curbuf = vim.api.nvim_get_current_buf()
    if terms[name] then
        if terms[name].buf == curbuf then
            vim.api.nvim_set_current_buf(prebuf)
        else
            prebuf = curbuf
            vim.api.nvim_set_current_buf(terms[name].buf)
            vim.cmd('startinsert')
        end
    else
        prebuf = curbuf
        create_term(name)
        vim.cmd('startinsert')
    end
end

local function run(name, cmd)
    local curbuf = vim.api.nvim_get_current_buf()
    if not terms[name] then
        create_term(name)
        if terms[name].buf ~= curbuf then
            vim.api.nvim_set_current_buf(terms[name].buf)
            vim.cmd('startinsert')
        end
        vim.api.nvim_chan_send(
            terms[name].term,
            cmd .. ' && exit' .. vim.api.nvim_replace_termcodes('<CR>', true, true, true)
        )
    else
        if terms[name].buf ~= curbuf then
            vim.api.nvim_set_current_buf(terms[name].buf)
            vim.cmd('startinsert')
        end
        vim.api.nvim_chan_send(
            terms[name].term,
            cmd .. ' && exit' .. vim.api.nvim_replace_termcodes('<CR>', true, true, true)
        )
    end
end

local wk = require('which-key')

wk.register({
    ['<leader>o'] = { function() toggle_term('main') end, 'Toggle Term' },
    ['<leader>b'] = { function() run('build', '(./build.sh % || exit) && test -f ./out && ./out') end, 'Run `build.sh` %' },
    ['<leader>tt'] = { function() run('tcomp', './run.sh ' .. vim.fn.expand('%')) end, 'Run `run.sh %` in tcomp' },
})

wk.register({
    name = 'Scratch Terminals',
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
    ['<leader>cr'] = { function() run('rust', 'cargo run') end, 'cargo run' },
    ['<leader>cb'] = { function() run('rust', 'cargo build') end, 'cargo build' },
    ['<leader>nb'] = { function() run('nb', 'npm run build') end, 'npm run build' },
    ['<leader>nw'] = { function() run('nw', 'npm run watch') end, 'npm run watch' },
    ['<leader>ns'] = { function() run('ns', 'npm run serve') end, 'npm run serve' },
})

