local wk = require('which-key')

wk.register({
    ['<leader>sf'] = { '<CMD>w<CR>', 'Save File' },
    ['<leader>xx'] = { '<CMD>source %<CR>', 'Run Current File' },
    ['<leader>rt'] = { ':LualineRenameTab ', 'Rename Tab', mode = n },
    ['<leader>tt'] = { '<CMD>TroubleToggle<CR>', 'Toggle Trouble' },
    ['<leader>q']  = { '<CMD>bd<CR>', 'Kill Buffer' },
    ['<leader>w']  = { '<CMD>close<CR>', 'Close Window' },
})

-- create windows / tabs / panes --
wk.register({
    ['<leader>tn'] = { '<CMD>tabnew<CR>', 'New Tab' },
    ['<leader>\\'] = { '<CMD>vsp<CR>', 'V Split' },
    ['<leader>-']  = { '<CMD>sp<CR>', 'H Split'  },
})

wk.register({
    ['<leader>'] = {
        p = { '<CMD>Telescope find_files<CR>', 'Find Files' },
        ['ls'] = { '<CMD>Telescope buffers<CR>', 'List Buffers' },
        ['rg'] = { '<CMD>Telescope live_grep<CR>', 'Live Grep' },
        ['he'] = { '<CMD>Telescope help_tags<CR>', 'Search Help' },
        ['ss'] = { '<CMD>Telescope treesitter<CR>', 'Search Symbols' },
        ['td'] = { '<CMD>TodoTelescope<CR>', 'Todo Telescope' },
    }
})

wk.register({
    ['<leader>gt'] = {
        name = '+git',
        s = { '<CMD>Telescope git_status<CR>', 'Git Status' },
        t = { '<CMD>Telescope git_stash<CR>', 'Git Stash' },
        b = { '<CMD>Telescope git_branches<CR>', 'Git Branches' },
        d = { '<CMD>Gitsigns diffthis<CR>', 'Git Diffthis' },
        a = { '<CMD>Gitsigns stage_buffer<CR>', 'Git Stage Buffer' },
    }
})

