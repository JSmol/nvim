vim.cmd('packadd termdebug')

vim.g.termdebug_config = {
    sign = '>>',
    wide = 1,
}

local debugger_active = false
local config = {
    binary = 'out',
    stdin = 'test.in',
    args = {
    },
}

if vim.fn.filereadable('./gdbconfig.json') > 0 then 
    local configfile = vim.fn.readfile('./gdbconfig.json')
    config = vim.fn.json_decode(configfile)
end

local function start()
    if (debugger_active) then
        vim.cmd('Gdb')
    else
        vim.cmd('Termdebug')
    end
end

local function reload()
    if (debugger_active) then
        vim.api.nvim_call_function('TermDebugSendCommand', {'file ' .. config.binary})
        vim.api.nvim_call_function('TermDebugSendCommand', {
            'run ' .. table.concat(config.args, ' ') .. " < " .. config.stdin
        })
    end
end

vim.api.nvim_create_autocmd('User', {
    pattern = 'TermdebugStartPre',
    callback = function()
        debugger_active = true
    end
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'TermdebugStartPost',
    callback = function()
        vim.api.nvim_call_function('TermDebugSendCommand', {'set confirm off'})
        reload()
        start()
    end
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'TermdebugStopPost',
    callback = function()
        debugger_active = false
    end
})

local wk = require('which-key')
wk.register({
    ['<leader>d'] = {
        name = '+debugger',
        d = { start, 'Start Debug or Focus GDB' },
        b = { '<CMD>Break<CR>', 'Set Breakpoint' },
        s = { '<CMD>Source<CR>', 'Focus Source' },
        k = { '<CMD>Down<CR>', 'Down the Frame Stack' },
        j = { '<CMD>Up<CR>', 'Up the Frame Stack' },
        o = { '<CMD>Over<CR>', 'Over' },
        c = { '<CMD>Continue<CR>', 'Continue Execution' },
        l = { '<CMD>Clear<CR>', 'Clear Breakpoint' },
        r = { reload, 'Reload && Run' },
    }
})
