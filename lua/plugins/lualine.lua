return {

  'nvim-lualine/lualine.nvim',

  init = function()
    local auto = require('lualine.themes.auto')
    auto.normal.b.bg = 'NONE'
    auto.normal.c.bg = 'NONE'
  end,

  opts = {

    options = {
      refresh = {
        statusline = 32, -- 30fps
        tabline = 100,
        winbar = 100,
      },
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = ' ', right = ' ' },
      section_separators = { left = ' ', right = ' ' },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },

    tabline = {
      lualine_a = { { 'filename', path = 1 } },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        {
          'tabs',
          mode = 2,
          tab_max_length = 20,
          max_length = function() return vim.o.columns / 2 end,
          use_mode_colors = true,
          symbols = { modified = ' 󰴓' },
        }
      }
    },

    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics', },
      lualine_c = { 'filetype', },
      lualine_x = { function() return require('job-manager'):getline() end },
      lualine_y = { function() return require('job-manager'):status() end },
      lualine_z = {},
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },

    winbar = {},
    inactive_winbar = {},
    extensions = { 'trouble' }

  }
}
