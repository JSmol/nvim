-- https://github.com/catppuccin/nvim
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  dependencies = {
    { 'lukas-reineke/indent-blankline.nvim', name = 'ibl', opts = {} }
  },
  init = function()
    vim.cmd('colorscheme catppuccin')
  end,
  opts = {
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
    },
    integrations = {
      cmp = true,
      treesitter = true,
      native_lsp = { enabled = true, },
      lsp_trouble = true,
      gitsigns = true,
      telescope = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      markdown = true,
    },
  }
}
