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
    end
    if terms[name].buf ~= curbuf then
        vim.api.nvim_set_current_buf(terms[name].buf)
        -- vim.cmd('startinsert')
    end
    vim.api.nvim_chan_send(
        terms[name].term,
        cmd .. ' || exit' .. vim.api.nvim_replace_termcodes('<CR>', true, true, true)
    )
end

vim.keymap.set('n', '<leader>tt', function() run('tcomp', './run.sh ' .. vim.fn.expand('%')) end)
-- '<CMD>term ./run.sh %<CR>i')

vim.keymap.set('n', '<leader>o', function() toggle_term('main') end)
vim.keymap.set('n', '<leader>sh1', function() toggle_term('scratch1') end)
vim.keymap.set('n', '<leader>sh2', function() toggle_term('scratch2') end)
vim.keymap.set('n', '<leader>sh3', function() toggle_term('scratch3') end)
vim.keymap.set('n', '<leader>sh4', function() toggle_term('scratch4') end)
vim.keymap.set('n', '<leader>sh5', function() toggle_term('scratch5') end)
vim.keymap.set('n', '<leader>sh6', function() toggle_term('scratch6') end)
vim.keymap.set('n', '<leader>sh7', function() toggle_term('scratch7') end)
vim.keymap.set('n', '<leader>sh8', function() toggle_term('scratch8') end)
vim.keymap.set('n', '<leader>sh9', function() toggle_term('scratch9') end)
vim.keymap.set('n', '<leader>sh0', function() toggle_term('scratch0') end)

vim.keymap.set('n', '<leader>r', function()
    run('run', '(./build.sh % || exit) && ./out && exit')
end)

vim.keymap.set('n', '<leader>cr', function() run('rust', 'cargo run') end)
vim.keymap.set('n', '<leader>cb', function() run('rust', 'cargo build') end)

vim.keymap.set('n', '<leader>nb', function() run('nb', 'npm run build') end)
vim.keymap.set('n', '<leader>nw', function() run('nw', 'npm run watch') end)
vim.keymap.set('n', '<leader>ns', function() run('ns', 'npm run serve') end)

