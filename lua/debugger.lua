local dap = require('dap')
local dapui = require('dapui')
require('nvim-dap-virtual-text').setup()

dapui.setup({
  controls = {
    element = 'repl',
    enabled = false,
  },
  layouts = { 
    {
      elements = {
        { id = 'scopes', size = 0.33 },
        { id = 'stacks', size = 0.33 },
        { id = 'breakpoints', size = 0.33 },
        -- { id = 'watches', size = 0.25 } 
      },
      position = 'bottom',
      size = 12
    },
    {
      elements = { 
        { id = 'repl', size = 0.5 },
        { id = 'console', size = 0.5 }
      },
      position = 'right',
      size = 0.33
    } 
  },
})

dap.adapters.odb = {
  type = 'executable',
  command = '/root/extension/debugAdapters/bin/OpenDebugAD7',
}

-- read ./debug.conf.json --
local config = {
    binary = './out',
    args = { },
}

function reload()
  if vim.fn.filereadable('./gdbconfig.json') > 0 then 
    local configfile = vim.fn.readfile('./gdbconfig.json')
    config = vim.fn.json_decode(configfile)
  end
  dap.run({
    name = 'Launch',
    type = 'odb',
    request = 'launch',
    program = config.binary,
    args = config.args,
    cwd = '${workspaceFolder}',
    setupCommands = {  
      { 
         text = '-enable-pretty-printing',
         description =  'enable pretty printing',
         ignoreFailures = false 
      },
    },
  })
end

local wk = require('which-key')
wk.register({
  ['<leader>d'] = {
    name = '+debugger',
    d = { dapui.toggle, 'Toggle Debug UI' },
    r = { reload, 'Reload && Run' },
    k = { dap.down, 'Down the Frame Stack' },
    j = { dap.up, 'Up the Frame Stack' },
    c = { dap.continue, 'Continue' },
    b = { dap.toggle_breakpoint, 'Toggle BP' },
  }
})
