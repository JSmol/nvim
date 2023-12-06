-- chat gpt functions in neovim --
-- requires `tgpt` binary --

-- visual mode chat
-- generate a function for sending visual selects to tgpt 
function vchat(mode, lang)
    return function()
        local fn = vim.fn.expand('%:p')
        local cr = vim.api.nvim_replace_termcodes('<CR>', true, true, true)
        local cmd = 'tgpt --mode=' .. mode .. ' --lang=' .. lang .. ' --files=' .. fn .. ' | tee /tmp/res' 
        vim.api.nvim_feedkeys(':w !' .. cmd .. cr, 'm', false)
        vim.api.nvim_feedkeys("'>", 'm', false)
        if mode == 'document' then -- move cursor above select
            vim.api.nvim_feedkeys('gvdk', 'm', false)
        end
        vim.api.nvim_feedkeys(':r /tmp/res' .. cr, 'm', false)
    end
end

local wk = require('which-key')

-- TODO: gpt things
wk.register({
    ['<leader>csc'] = { vchat('suggest', 'c'), 'Code Suggest C', mode = 'v' }
    -- ['<leader>csp'] = { vchat('suggest', 'python'), 'Code Suggest Python', mode = 'v' },
})

    -- ['<leader>csr'] = { vchat('suggest', 'rust'), 'Code Suggest Rust', mode = 'v' },
    -- ['<leader>cdr'] = { vchat('document', 'rust'), 'Code Document Rust', mode = 'v' }

