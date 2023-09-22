local fterm = require('FTerm')

fterm.setup({
  dimensions = {
    height = 0.9,
    width = 0.9
  },
  border = 'single'
})

-- map keys helper --
local function map(lhs, rhs)
    vim.api.nvim_set_keymap('n', lhs, rhs, {noremap=true, silent=true})
    vim.api.nvim_set_keymap('i', lhs, rhs, {noremap=true, silent=true})
    vim.api.nvim_set_keymap('t', lhs, rhs, {noremap=true, silent=true})
end

-- toggle term --
vim.api.nvim_create_user_command('FTermToggle', 
    function() 
        fterm.toggle()
    end, { bang = true })
map('<C-o>', '<CMD>FTermToggle<CR>')

-- map keys helper --
local function map(lhs, rhs)
  vim.api.nvim_set_keymap('n', lhs, rhs, {noremap=true, silent=true})
  vim.api.nvim_set_keymap('i', lhs, rhs, {noremap=true, silent=true})
  vim.api.nvim_set_keymap('t', lhs, rhs, {noremap=true, silent=true})
end

vim.api.nvim_create_user_command('Run', function()
  fterm.run('./run.sh')
end, { })
map('<leader>r', '<CMD>Run<CR>')

vim.api.nvim_create_user_command('Build', function()
  fterm.run({'./build.sh'})
end, { })
map('<leader>b', '<CMD>Build<CR>')

----- RUST -----
-- commands to run in main terminal --
vim.api.nvim_create_user_command('CargoRun', function()
  fterm.run({'cargo', 'run'})
end, { })
map('<leader>cr', '<CMD>CargoRun<CR>')

vim.api.nvim_create_user_command('CargoFmt', function()
  fterm.run({'cargo', 'fmt'})
end, { })
map('<leader>cf', '<CMD>CargoFmt<CR>')

vim.api.nvim_create_user_command('WasmBuild', function()
  fterm.run({'wasm-pack', 'build'})
end, { })
map('<leader>cwa', '<CMD>WasmBuild<CR>')

----- JAVASCRIPT -----
vim.api.nvim_create_user_command('NpmBuild', function()
  fterm.run({'npm', 'run', 'build'})
end, { })
map('<leader>nb', '<CMD>NpmBuild<CR>')

---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
-- toggle long running command in new terminal --
local watch_term = fterm:new({ft = 'ft_watch', cmd = "npm run watch"})
vim.api.nvim_create_user_command('Watch', function()
  watch_term:toggle();
end, { })
map('<leader>nw', '<CMD>Watch<CR>')

local serve_term = fterm:new({ft = 'ft_serve', cmd = "npm run serve"})
vim.api.nvim_create_user_command('Serve', function()
  serve_term:toggle();
end, { })
map('<leader>ns', '<CMD>Serve<CR>')

