    return require('lazy').setup({

    { 'catppuccin/nvim', name = 'catppuccin' },

    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
    'nvim-lualine/lualine.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'easymotion/vim-easymotion',
    'tikhomirov/vim-glsl',

    -- lsp and completion --
    'neovim/nvim-lspconfig',
    'simrat39/rust-tools.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'kdheepak/cmp-latex-symbols',

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        "cbochs/grapple.nvim",
        config = function()
            require("grapple").setup()
        end
    },

    {
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
    },

    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup()
        end
    },

    {
        'folke/todo-comments.nvim',
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
    },

    {
        'folke/zen-mode.nvim',
        config = function()
          require("zen-mode").setup()
        end
    },

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    },

})
