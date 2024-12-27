-- https://github.com/folke/todo-comments.nvim
return {
  'folke/todo-comments.nvim',
  opts = {
    signs = true,
    sign_priority = 8,
    keywords = {
      ISSUE = { icon = ' ', color = 'error', alt = { 'FIX', 'BUG', 'ISSUE' } },
      NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
      TODO = { icon = ' ', color = 'info' },
    },
    merge_keywords = true,
    highlight = {
      before = '',
      keyword = 'bg',
      after = 'fg',
      pattern = [[.*<(KEYWORDS)\s*:]],
      comments_only = true,
      max_line_len = 400,
      exclude = {},
    },
    search = {
      command = 'rg',
      args = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
      },
      pattern = [[\b(KEYWORDS):]],
    }
  }
}
