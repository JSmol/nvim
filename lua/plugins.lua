-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()

  -- Packer can manage itself https://github.com/wbthomason/packer.nvim
  use 'wbthomason/packer.nvim'

  -- colorscheme --
  use {
    'catppuccin/nvim',
    as = 'catppuccin'
  }

  -- https://github.com/nvim-treesitter/nvim-treesitter
  use 'nvim-treesitter/nvim-treesitter'

  -- https://github.com/nvim-telescope/telescope.nvim
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- https://github.com/nvim-lualine/lualine.nvim
  use { 'nvim-lualine/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true} }

  -- https://github.com/neovim/nvim-lspconfig
  use 'neovim/nvim-lspconfig'

  -- https://github.com/hrsh7th/nvim-cmp
  use 'hrsh7th/nvim-cmp'
  -- https://github.com/hrsh7th/cmp-nvim-lsp
  use 'hrsh7th/cmp-nvim-lsp'

  -- snippets and cmp plugins
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-emoji'

  -- pairs and indentation guide
  use { 
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  use {
    'lukas-reineke/indent-blankline.nvim', branch = 'master',
    config = function()
      require('indent_blankline').setup()
    end
  }

  -- https://github.com/easymotion/vim-easymotion
  use { 'easymotion/vim-easymotion' }

  -- https://github.com/folke/todo-comments.nvim
  use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }

  -- https://github.com/numToStr/Comment.nvim
  use {
    'numToStr/Comment.nvim',
    require('Comment').setup()
  }

  -- rust things https://github.com/simrat39/rust-tools.nvim
  use 'simrat39/rust-tools.nvim'
  use {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
    end,
  }

  use {
    'folke/zen-mode.nvim',
    config = function()
      require("zen-mode").setup()
    end
  }

  use 'nvim-tree/nvim-tree.lua'

  -- config at lua/terminal
  use 'numToStr/FTerm.nvim'

  use 'tikhomirov/vim-glsl'

end)
