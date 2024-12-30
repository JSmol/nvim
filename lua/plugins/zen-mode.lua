-- https://github.com/folke/zen-mode.nvim
return {
  'folke/zen-mode.nvim',
  opts = {
    window = {
      backdrop = 1,
      width = 120,
      height = 1,
    },
    plugins = {
      -- disable some global vim options (vim.o...)
      -- comment the lines to not apply the options
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
        laststatus = 3,
      },
      twilight = { enabled = false },
    },
    -- callback where you can add custom code when the Zen window opens
    on_open = function(win)
    end,
    -- callback where you can add custom code when the Zen window closes
    on_close = function()
    end,
  },
  keys = { { '<leader>zz', function() require('zen-mode').toggle() end, desc = 'Zen Mode' } }
}
