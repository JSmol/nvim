-- custom backgrounds for transparent terminal --
local auto = require('lualine.themes.auto')
auto.normal.b.bg = 'NONE'
auto.normal.c.bg = 'NONE'

require('lualine').setup({

  options = {
    icons_enabled = true,
    theme = auto,
    component_separators = { left = ' ', right = ''},
    section_separators = { left = ' ', right = ' '},
    disabled_filetypes = {},
    always_divide_middle = true,
  },

  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      {
        'filename',
        path=1
      }
    },
    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {
      'location'
    }
  },

  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },

  tabline = {
    lualine_a = {
      {
        'buffers',
        show_filename_only = false,
        use_mode_colors = true
      }
    },
    -- lualine_b = {},
    lualine_b = {
    },
    -- lualine_c = {},
    -- lualine_x = {},
    -- lualine_y = {},
    lualine_z = {
      {
        'tabs',
        use_mode_colors = true
      }
    }
  },

  winbar = {},

  extensions = {}

})
