-- https://github.com/nvim-telescope/telescope.nvim
return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    telescope.setup({
      defaults = {
        prompt_prefix = ' ',
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<ESC>'] = actions.close,
            ['<Tab>'] = actions.move_selection_next,
            ['<S-Tab>'] = actions.move_selection_previous,
          }
        },
        file_ignore_patterns = {
          'node_modules',
          'public',
          'dist',
          'pkg',
          'env',
          'media',
          'typings',
          '__pycache__',
          'target',
          '%.wav',
          '%.jpg',
          '%.png',
          '%.csv',
        }
      }
    })
  end
}
