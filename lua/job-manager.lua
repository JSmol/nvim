local JobManager = {}
JobManager.__index = JobManager

local path = require('plenary.path')
local strings = require('plenary.strings')

local function load_config()
  local config = './jobs.txt'
  if vim.fn.filereadable(config) > 0 then
    return vim.fn.readfile(config)
  else
    return {}
  end
end

function JobManager:new()
  local obj = {
    jobs = {},
    cmds = load_config(),
    last = nil
  }
  return setmetatable(obj, self)
end

-- get buffer for file path
local function getbuf(p)
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    if vim.api.nvim_buf_get_name(buf) == p:absolute() then
      return buf
    end
  end
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(buf, p:absolute())
  return buf
end

local function replace_buf(buf, new_buf)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if buf == vim.api.nvim_win_get_buf(win) then
      vim.api.nvim_win_set_buf(win, new_buf)
    end
  end
end

function JobManager:create(cmd)
  local loc = cmd:find(' ') or #cmd + 1
  local filepath = path:new('./logs', cmd:sub(0, loc - 1) .. vim.fn.strftime('%s'))
  local job = {
    cmd = cmd,
    exited = false,
    termbuf = vim.api.nvim_create_buf(true, true),
    termcwd = vim.fn.getcwd(),
    filepath = filepath,
  }
  table.insert(self.jobs, job)
  self.last = job
  vim.api.nvim_buf_call(job.termbuf, function()
    job.terminal = vim.fn.termopen(
      cmd .. ' 2>&1 | tee ' .. job.filepath:absolute(),
      {
        on_exit = function()
          self.last = job
          job.exited = true
          local filebuf = getbuf(job.filepath)
          vim.api.nvim_buf_call(filebuf, function() vim.cmd('edit!') end)
          replace_buf(job.termbuf, filebuf)
          vim.api.nvim_buf_delete(job.termbuf, {})
          vim.notify('Jobs DONE!', vim.log.levels.INFO, {})
        end
      }
    )
  end)
end

function JobManager:listjobs()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local picker = function(opts)
    opts = opts or {}
    pickers.new(opts, {
      prompt_title = 'Completed and Running Jobs',
      finder = finders.new_table {
        results = self.jobs,
        entry_maker = function(entry)
          return {
            value = entry,
            ordinal = entry.cmd,
            display = function()
              local progress = entry.exited and " " or " "
              return progress .. entry.cmd .. ' >> ' .. entry.filepath:absolute()
            end
          }
        end
      },
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local sel = action_state.get_selected_entry()
          if sel == nil then return end
          local job = sel.value
          if job.exited then
            local filebuf = getbuf(job.filepath)
            vim.api.nvim_buf_call(filebuf, function() vim.cmd('edit!') end)
            vim.api.nvim_set_current_buf(filebuf)
          else
            vim.api.nvim_set_current_buf(job.termbuf)
          end
        end)
        return true
      end,
    }):find()
  end
  picker()
end

function JobManager:listcmds()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local picker = function(opts)
    opts = opts or {}
    pickers.new(opts, {
      prompt_title = 'Run Job',
      finder = finders.new_table {
        results = self.cmds,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry,
            ordinal = entry,
          }
        end
      },
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local cmd = action_state.get_selected_entry().value
          self:create(cmd)
        end)
        return true
      end,
    }):find()
  end
  picker()
end

function JobManager:getline()
  if self.last ~= nil then
    local job = self.last
    if vim.api.nvim_buf_is_valid(job.termbuf) then
      local last = vim.api.nvim_buf_get_lines(job.termbuf, -2, -1, true)
      assert(#last == 1)
      local result = table.concat(last)
      result = strings.align_str(result, 60, true)
      result = strings.truncate(result, 60)
      return result
    end
  end
  return ''
end

function JobManager:status()
  if self.last == nil then
    return 'No Jobs!'
  else
    local job = self.last
    local progress = job.exited and ' ' or ' '
    return strings.truncate(job.cmd, 20) .. ' ' .. progress
  end
end

return JobManager:new()
