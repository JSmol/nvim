local catppuccin = require("catppuccin")
local mocha = require('catppuccin.palettes').get_palette('mocha')

vim.opt.cursorline = true

-- indentation guides --
require('ibl').setup()

catppuccin.setup({
    flavour = 'mocha',
    color_overrides = {
        mocha = {
            -- base = "#ff0000",
            -- mantle = "#242424",
            -- crust = "#474747",
        },
    },
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
    },
    integrations = {
        cmp = true,
        harpoon = true,
        treesitter = true,
        native_lsp = {
            enabled = true,
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

vim.cmd('colorscheme catppuccin')
