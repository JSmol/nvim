local function move(mode, direction)
  local trouble = require('trouble')
  trouble[direction](mode)
  trouble.jump(mode, {})
end
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {
    auto_preview = false,
    focus = false,
    modes = { symbols = { win = { position = 'left' } } }
  },
  keys = {
    { '<leader>dd', function() require('trouble').toggle('diagnostics') end, desc = 'Diagnostics (Trouble)' },
    { '<leader>dj', function() move('diagnostics', 'next') end,              desc = 'Next Diagnostic' },
    { '<leader>dk', function() move('diagnostics', 'prev') end,              desc = 'Prev Diagnostic' },
    { '<leader>ds', function() require('trouble').toggle('symbols') end,     desc = 'Symbols (Trouble)' },
    -- { '<leader>dj', function() move('symbols', 'next') end,                  desc = 'Next Symbol' },
    -- { '<leader>dk', function() move('symbols', 'prev') end,                  desc = 'Prev Symbol' },
  },
}
