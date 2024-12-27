local TerminalManager = {}
TerminalManager.__index = TerminalManager

function TerminalManager:new()
  local obj = {}
  obj.terminals = {}
  vim.api.nvim_create_autocmd('WinLeave', {
    pattern = 'term://*',
    callback = function(args)
      for name, term in pairs(obj.terminals) do
        if term.buf == args.buf and term.win then
          obj:close(name)
        end
      end
    end
  })
  return setmetatable(obj, self)
end

-- create a new named terminal
function TerminalManager:create(name, cmd)
  if not self.terminals[name] then
    local curbuf = vim.api.nvim_get_current_buf()
    self.terminals[name] = {
      exited = false,
      buf = vim.api.nvim_create_buf(true, false),
      cwd = vim.fn.getcwd(),
      win = nil
    }
    vim.api.nvim_set_current_buf(self.terminals[name].buf)
    self.terminals[name].terminal = vim.fn.termopen(
      cmd,
      {
        on_exit = function()
          self.terminals[name] = nil
          vim.notify('job ' .. name .. ' complete!', vim.log.levels.INFO)
        end
      }
    )
    vim.api.nvim_set_current_buf(curbuf)
  end
end

function TerminalManager:open(name, cmd)
  if cmd then
    self:create(name, cmd)
    if not self.terminals[name].win then
      local hpad = 6
      local vpad = 3
      local cols = vim.o.columns
      local rows = vim.o.lines
      vim.api.nvim_open_win(
        self.terminals[name].buf,
        true,
        {
          title = name,
          relative = 'editor',
          col = hpad,
          row = vpad - 2, -- accounting for status bars.
          width = cols - 2 * hpad,
          height = rows - 2 * vpad,
          zindex = 150,
          border = 'rounded',
        }
      )
      self.terminals[name].win = vim.api.nvim_get_current_win()
      vim.cmd('startinsert')
    end
  end
end

function TerminalManager:close(name)
  vim.api.nvim_win_close(self.terminals[name].win, false)
  self.terminals[name].win = nil
end

function TerminalManager:toggle(name, cmd)
  if self.terminals[name] and self.terminals[name].win then
    self:close(name)
  else
    self:open(name, cmd)
  end
end

return TerminalManager:new()
