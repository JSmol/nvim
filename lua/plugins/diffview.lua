return {
  'sindrets/diffview.nvim',
  keys = {
    { '<leader>vd', function() require('diffview').open({}) end, desc = 'Open DiffView' }
  }
}
