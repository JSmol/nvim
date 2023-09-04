local catppuccin = require("catppuccin")

local mocha = require('catppuccin.palettes').get_palette('mocha')

catppuccin.setup({
  flavour = 'mocha',
  custom_highlights = function(colors)
    return {
      Folded = { fg = colors.lavender },
      CursorLine = { bg = colors.base },
      FloatBorder = { fg = colors.rose },
    }
  end,
  transparent_background = true,
  term_colors = false,
  styles = {
    comments = { "italic" },
    functions = { "bold" },
    keywords = { "bold" },
    -- strings = { "NONE" },
    -- variables = { "NONE" },
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "bold" },
        hints = { "bold" },
        warnings = { "bold" },
        information = { "bold" },
      },
      underlines = {
        -- errors = "underline",
        -- hints = "underline",
        -- warnings = "underline",
        -- information = "underline",
      },
    },
    lsp_trouble = true,
    gitsigns = true,
    telescope = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    markdown = true,
  },
})
