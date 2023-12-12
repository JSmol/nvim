local wk = require('which-key')

wk.register({
    ['<leader>sf'] = { '<CMD>w<CR>', 'Save File' },
    ['<leader>xx'] = { '<CMD>source %<CR>', 'Run Current File' },
    ['<leader>q']  = { '<CMD>bd<CR>', 'Kill Buffer' },
    ['<leader>w']  = { '<CMD>close<CR>', 'Close Window' },
    ['<leader>z']  = { '<CMD>ZenMode<CR>', 'Toggle ZenMode' },
})

-- windows / tabs / panes --
wk.register({
    ['<leader>kk'] = { '<CMD>wincmd k<CR><ESC>', 'Move up' },
    ['<leader>jj'] = { '<CMD>wincmd j<CR><ESC>', 'Move down' },
    ['<leader>hh'] = { '<CMD>wincmd h<CR><ESC>', 'Move left' },
    ['<leader>ll'] = { '<CMD>wincmd l<CR><ESC>', 'Move right' },
    ['<leader>tn'] = { '<CMD>tabnew<CR>', 'New Tab' },
    ['<leader>\\'] = { '<CMD>vsp<CR>', 'V Split' },
    ['<leader>-']  = { '<CMD>sp<CR>', 'H Split'  },
})

-- telescope --
wk.register({
    ['<leader>'] = {
        p = { '<CMD>Telescope find_files<CR>', 'Find Files' },
        ['ls'] = { '<CMD>Telescope buffers<CR>', 'List Buffers' },
        ['lg'] = { '<CMD>Telescope live_grep<CR>', 'Live Grep' },
        ['he'] = { '<CMD>Telescope help_tags<CR>', 'Search Help' },
        ['ss'] = { '<CMD>Telescope treesitter<CR>', 'Search Symbols' },
        ['td'] = { '<CMD>TodoTelescope<CR>', 'Search Symbols' },
        g = {
            name = '+git',
            s = { '<CMD>Telescope git_status<CR>', 'Git Status' },
            t = { '<CMD>Telescope git_stash<CR>', 'Git Stash' },
            -- b = { '<CMD>Telescope git_branches<CR>', 'Git Branches' },
        }
    }
})

-- better marks --
local grapple = require("grapple")
wk.register({
    ['<leader>m'] = { '<CMD>GrappleToggle<CR>', 'Toggle Mark' },
    ['<leader>e'] = { '<CMD>GrapplePopup tags<CR>', 'Grapple Popup' },
    ['<leader>1'] = { function() grapple.select({ key = 1 }) end, 'Goto Mark' },
    ['<leader>2'] = { function() grapple.select({ key = 2 }) end, 'Goto Mark' },
    ['<leader>3'] = { function() grapple.select({ key = 3 }) end, 'Goto Mark' },
    ['<leader>4'] = { function() grapple.select({ key = 4 }) end, 'Goto Mark' },
    ['<leader>5'] = { function() grapple.select({ key = 5 }) end, 'Goto Mark' },
    ['<leader>6'] = { function() grapple.select({ key = 6 }) end, 'Goto Mark' },
    ['<leader>7'] = { function() grapple.select({ key = 7 }) end, 'Goto Mark' },
    ['<leader>8'] = { function() grapple.select({ key = 8 }) end, 'Goto Mark' },
    ['<leader>9'] = { function() grapple.select({ key = 9 }) end, 'Goto Mark' },
    ['<leader>0'] = { function() grapple.select({ key = 0 }) end, 'Goto Mark' },
})

-- folds --
wk.register({
    ['<leader>f'] = {
        name = 'folds',
        z = { 'za', 'Fold Cursor' },
        a = { '<CMD>set foldlevel=0<CR>', 'Fold All' },
        s = { '<CMD>set foldlevel=99<CR>', 'Fold Reset' },
        ['1'] = { '<CMD>set foldlevel=1<CR>', 'Fold Level' },
        ['2'] = { '<CMD>set foldlevel=2<CR>', 'Fold Level' },
        ['3'] = { '<CMD>set foldlevel=3<CR>', 'Fold Level' },
        ['4'] = { '<CMD>set foldlevel=4<CR>', 'Fold Level' },
        ['5'] = { '<CMD>set foldlevel=5<CR>', 'Fold Level' },
    }
})

-- obsidian --
wk.register({
    ['<leader>d'] = {
        name = '+obsidian',
        f = { '<CMD>ObsidianFollowLink<CR>', 'Obsidian Follow' },
        b = { '<CMD>ObsidianBacklinks<CR>', 'Obsidian Backlinks' },
        l = { '<CMD>ObsidianLink<CR>', 'Obsidian Link' },
        n = { '<CMD>ObsidianNew ', 'Obsidian New' },
    }
})

-- random stuff --
wk.register({
    ['<leader>kb'] = { '<CMD>e ~/.config/nvim/lua/keyboard.lua<CR>', 'Open Neovim keyboard.lua' },
    ['<leader>nv'] = { '<CMD>e ~/.config/nvim/readme.md<CR>', 'Open Neovim readme.md' },
    ['<leader>sk'] = { '<CMD>term python ~/projects/kattis-cli/submit.py %<CR>i', 'Send current file to kattis.com' },
    ['<leader>tp'] = { '<CMD>r ~/competitive-programming/template.cc<CR>ggdd', 'Copy C++ Template' },
    ['<leader>in'] = { '<CMD>e %:h/test.in<CR>', 'Open test.in' },
})

