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
        vim.cmd('startinsert')
    end
    vim.api.nvim_chan_send(
        terms[name].term,
        cmd .. vim.api.nvim_replace_termcodes('<CR>', true, true, true)
    )
end

vim.keymap.set('n', '<C-o>', function() toggle_term('main') end)
vim.keymap.set('v', '<C-o>', function() toggle_term('main') end)
vim.keymap.set('t', '<C-o>', function() toggle_term('main') end)
vim.keymap.set('i', '<C-o>', function() toggle_term('main') end)

vim.keymap.set('n', '<leader>r', function() run('main', './run.sh') end)
vim.keymap.set('n', '<leader>b', function() run('main', './build.sh') end)

vim.keymap.set('n', '<leader>cr', function() run('rust', 'cargo run') end)
vim.keymap.set('n', '<leader>cb', function() run('rust', 'cargo build') end)

vim.keymap.set('n', '<leader>nb', function() run('node', 'npm run build') end)
vim.keymap.set('n', '<leader>nw', function() run('node', 'npm run watch') end)
vim.keymap.set('n', '<leader>nw', function() run('node', 'npm run serve') end)

