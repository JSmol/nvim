-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)

    -- https://github.com/wbthomason/packer.nvim
    use 'wbthomason/packer.nvim'

    -- https://github.com/nvim-lua/plenary.nvim
    use 'nvim-lua/plenary.nvim'

    -- https://github.com/catppuccin/nvim
    use { 'catppuccin/nvim', as = 'catppuccin' }

    -- https://github.com/nvim-tree/nvim-web-devicons
    use { 'nvim-tree/nvim-web-devicons' }

    -- https://github.com/nvim-treesitter/nvim-treesitter
    use 'nvim-treesitter/nvim-treesitter'
    use 'tikhomirov/vim-glsl'

    -- https://github.com/hrsh7th/nvim-cmp
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/cmp-emoji',
            'kdheepak/cmp-latex-symbols',
        }
    }

    -- https://github.com/simrat39/rust-tools.nvim
    use 'simrat39/rust-tools.nvim'
    use {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        config = function()
            require('crates').setup()
        end,
    }

    -- https://github.com/cbochs/grapple.nvim
    use {
        "cbochs/grapple.nvim",
        config = function()
            require("grapple").setup()
        end
    }

    -- https://github.com/nvim-telescope/telescope.nvim
    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')
            telescope.setup({
                defaults = {
                    prompt_prefix = " ",
                    path_display = { "smart" },
                    mappings = {
                        i = {
                            ["<ESC>"] = actions.close,
                            ["<Tab>"] = actions.move_selection_next,
                            ["<S-Tab>"] = actions.move_selection_previous,
                        }
                    },
                    file_ignore_patterns = {
                        "node_modules",
                        "public",
                        "dist",
                        "pkg",
                        "env",
                        "media",
                        "typings",
                        "__pycache__",
                        "target",
                        "%.wav",
                        "%.jpg",
                        "%.png",
                    }
                }
            })
        end
    }

    -- https://github.com/nvim-lualine/lualine.nvim
    use 'nvim-lualine/lualine.nvim'

    -- https://github.com/lukas-reineke/indent-blankline.nvim
    use 'lukas-reineke/indent-blankline.nvim'
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end
    }

    -- https://github.com/easymotion/vim-easymotion
    use { 'easymotion/vim-easymotion' }

    -- https://github.com/folke/todo-comments.nvim
    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup({
                signs = true, -- show icons in the signs column
                sign_priority = 8, -- sign priority
                -- keywords recognized as todo comments
                keywords = {
                    FIX = { icon = " ", color = "error", alt = { "FIX", "BUG", "ISSUE" } },
                    TODO = { icon = " ", color = "info" },
                    HACK = { icon = " ", color = "warning" },
                    WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                    PERF = { icon = "󰅒 ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                    NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                    TEST = { icon = "󰙨 ", color = "hint", alt = { "TESTING", "TESTS" } },
                },
                merge_keywords = true,
                highlight = {
                    before = "",
                    keyword = "bg",
                    after = "fg",
                    pattern = [[.*<(KEYWORDS)\s*:]],
                    comments_only = true,
                    max_line_len = 400,
                    exclude = {},
                },
                colors = {
                    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                    warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
                    info = { "DiagnosticInfo", "#2563EB" },
                    hint = { "DiagnosticHint", "#10B981" },
                    default = { "Identifier", "#7C3AED" },
                },
                search = {
                    command = "rg",
                    args = {
                      "--color=never",
                      "--no-heading",
                      "--with-filename",
                      "--line-number",
                      "--column",
                    },
                    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                }
            })
        end
    }

    -- https://github.com/numToStr/Comment.nvim
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        'folke/zen-mode.nvim',
        config = function()
          require("zen-mode").setup()
        end
    }

    -- https://github.com/lewis6991/gitsigns.nvim
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

    -- https://github.com/folke/trouble.nvim
    use {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup()
        end
    }

end)

