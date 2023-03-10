-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()

  -- Packer can manage itself https://github.com/wbthomason/packer.nvim
  use('wbthomason/packer.nvim')

  -- colorscheme --
  use({
    "catppuccin/nvim",
    as = "catppuccin"
  })

  -- https://github.com/nvim-treesitter/nvim-treesitter
  use 'nvim-treesitter/nvim-treesitter'

  -- https://github.com/nvim-telescope/telescope.nvim
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- https://github.com/akinsho/nvim-bufferline.lua
  use { 'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons' }

  -- https://github.com/nvim-lualine/lualine.nvim
  use { 'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }

  -- https://github.com/neovim/nvim-lspconfig
  use 'neovim/nvim-lspconfig'

  -- https://github.com/hrsh7th/nvim-cmp
  use 'hrsh7th/nvim-cmp'

  -- https://github.com/hrsh7th/cmp-nvim-lsp
  use 'hrsh7th/cmp-nvim-lsp'

  -- idk snippet engine
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'

  use 'hrsh7th/cmp-emoji'

  -- https://github.com/akinsho/toggleterm.nvim
  use 'akinsho/toggleterm.nvim'

  -- pairs and indentation guide
  use 'windwp/nvim-autopairs'
  use { 'lukas-reineke/indent-blankline.nvim', branch = 'master' }

  -- https://github.com/easymotion/vim-easymotion
  use { 'easymotion/vim-easymotion' }

  -- https://github.com/lervag/vimtex
  use { 'lervag/vimtex' }

  -- https://github.com/dag/vim-fish
  use { 'dag/vim-fish' }

  -- https://github.com/folke/todo-comments.nvim
  use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- https://github.com/numToStr/Comment.nvim
  use { 'numToStr/Comment.nvim' }

end)
