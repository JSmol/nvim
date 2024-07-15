local dap = require('dap')
local dapui = require('dapui')
-- require('nvim-dap-virtual-text').setup()

dap.adapters.odb = {
  type = 'executable',
  command = '/root/extension/debugAdapters/bin/OpenDebugAD7',
}

-- read ./debug.conf.json --
local config = {
  binary = './out',
  args = { },
}

local function parse_config()
  if vim.fn.filereadable('./debug.conf.json') > 0 then
    local configfile = vim.fn.readfile('./debug.conf.json')
    config = vim.fn.json_decode(configfile)
  end
end

local function configurations()
  parse_config()
  return config
end

local function floater(elem)
  return function()
    dapui.float_element(elem, {
      width = 120,
      height = 20,
      enter = true,
      position = 'center'
    })
  end
end

-- print(vim.inspect(configurations()))

-- function set_win_opts(win)
--   vim.wo[win].relativenumber = false
--   vim.wo[win].number = false
--   vim.wo[win].statusline = ''
-- end
--
-- local windows = {}
-- local debug_window = nil
-- local debugger_open = false
-- local debugger_initialized = false
-- vim.api.nvim_set_option_value('switchbuf', 'usetab,newtab', {})
--
-- function init()
--   if not debugger_initialized then
--     debugger_initialized = true
--     local widgets = require('dap.ui.widgets')
--     vim.cmd('tabnew debug.conf.json')
--     vim.cmd('LualineRenameTab DEBUG')
--     debug_window = vim.api.nvim_get_current_win()
--
--     vim.cmd('botright vsplit')
--     local terminal_win = vim.api.nvim_get_current_win()
--     local buf = vim.api.nvim_create_buf(true, false)
--     vim.api.nvim_set_current_buf(buf)
--     dap.defaults.fallback.terminal_win_cmd = function()
--       return buf
--     end
--
--     vim.cmd('botright 12split')
--     local frame_win = vim.api.nvim_get_current_win()
--     set_win_opts(frame_win)
--     windows.frames = widgets.builder(widgets.frames)
--       .new_win(function()
--         return frame_win
--       end)
--       .build()
--
--     vim.cmd('vsplit')
--     local scope_win = vim.api.nvim_get_current_win()
--     set_win_opts(frame_win)
--     windows.scopes = widgets.builder(widgets.scopes)
--       .new_win(function()
--         return scope_win
--       end)
--       .build()
--
--     dap.repl.open(nil, 'vsplit')
--     windows.frames.open()
--     windows.scopes.open()
--   end
-- end
--
-- function reload()
--   dap.run({
--     name = 'Launch',
--     type = 'odb',
--     request = 'launch',
--     program = config.binary,
--     args = config.args,
--     cwd = '${workspaceFolder}',
--     setupCommands = {  
--       { 
--         text = '-enable-pretty-printing',
--         description =  'enable pretty printing',
--         ignoreFailures = false 
--       },
--     },
--   })
-- end
--
-- function start()
--   init()
--   reload()
--   windows.scopes.refresh()
--   windows.frames.refresh()
--   vim.api.nvim_set_current_win(debug_window)
-- end
--
-- vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='👉', texthl='', linehl='', numhl=''})
--
-- function runcmd(cmd)
--   return function()
--     cmd()
--     windows.scopes.refresh()
--     windows.frames.refresh()
--   end
-- end

local function toggle()
  dapui.toggle()
end

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local targets = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = 'Debug Targets',
    finder = finders.new_table {
      results = configurations()['configurations']
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        print(vim.inspect(selection))
      end)
      return true
    end,
  }):find()
end

local function setup()
  targets()
end

local wk = require('which-key')
wk.register({
  ['<leader>d'] = {
    name = '+debugger',
    o = { dapui.open, 'Open!' },
    c = { dapui.close, 'Close!' },
    d = { setup, 'Debug!!' },
    f = { floater('stacks'), 'Debug!!' },
    -- c = { runcmd(dap.continue), 'Continue' },
    -- j = { runcmd(dap.up), 'Up the Frame Stack' },
    -- k = { runcmd(dap.down), 'Down the Frame Stack' },
    -- b = { runcmd(dap.toggle_breakpoint), 'Toggle BP' },
  }
})
