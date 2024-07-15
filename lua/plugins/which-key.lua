return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 400
  end,
  opts = {
    window = {
      border = 'single', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
    }
  }
}
