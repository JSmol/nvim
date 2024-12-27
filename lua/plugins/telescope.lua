-- https://github.com/nvim-telescope/telescope.nvim
return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    telescope.setup({
      defaults = {
        preview = false,
        prompt_prefix = ' ',
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<ESC>'] = actions.close,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-a>'] = actions.toggle_selection,
            ['<C-q>'] = actions.add_selected_to_qflist,
          }
        },
        file_ignore_patterns = {
          'node_modules',
          '__pycache__',
          '%.wav',
          '%.jpg',
          '%.png',
          '%.csv',
        }
      }
    })
  end
}
