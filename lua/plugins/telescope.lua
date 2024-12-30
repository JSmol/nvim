-- https://github.com/nvim-telescope/telescope.nvim
local function builtin(picker)
  return function()
    local themes = require('telescope.themes')
    require('telescope.builtin')[picker](themes.get_ivy())
  end
end
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
            ['<C-f>'] = actions.send_to_qflist,
            ['<C-q>'] = actions.delete_buffer,
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
      },
    })
  end,
  keys = {
    { '<leader>p',  builtin('find_files'),           desc = 'Find Files' },
    { '<leader>sg', builtin('live_grep'),            desc = 'Search Grep' },
    { '<leader>sb', builtin('buffers'),              desc = 'Search Buffers' },
    { '<leader>sh', builtin('help_tags'),            desc = 'Search Help' },
    { '<leader>ss', builtin('lsp_document_symbols'), desc = 'Search Symbols' },
    { '<leader>gr', builtin('lsp_references'),       desc = 'GOTO References' },
    { '<leader>gd', builtin('lsp_definitions'),      desc = 'GOTO Definitions' },
    { '<leader>gi', builtin('lsp_implementations'),  desc = 'GOTO Implementations' },
  }
}
