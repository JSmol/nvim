return require('lazy').setup({

    { 'catppuccin/nvim', name = 'catppuccin' },

    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
    'nvim-lualine/lualine.nvim',
    'lukas-reineke/indent-blankline.nvim',

    -- lsp and completion --
    'neovim/nvim-lspconfig',
    'simrat39/rust-tools.nvim',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'kdheepak/cmp-latex-symbols',
    'windwp/nvim-autopairs',

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({ current_line_blame = true })
        end
    },

    {
        "folke/trouble.nvim",
        config = function()
            require('trouble').setup({
                padding = false
            })
        end
    },

    {
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
    },

    {
        'nvim-telescope/telescope.nvim',
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
    },

    {
        'folke/todo-comments.nvim',
        config = function()
            require('todo-comments').setup({
                signs = true, -- show icons in the signs column
                sign_priority = 8, -- sign priority
                -- keywords recognized as todo comments
                keywords = {
                    FIX = { icon = ' ', color = 'error', alt = { 'FIX', 'BUG', 'ISSUE' } },
                    TODO = { icon = ' ', color = 'info' },
                    HACK = { icon = ' ', color = 'warning' },
                    WARN = { icon = ' ', color = 'warning', alt = { 'WARNING', 'XXX' } },
                    PERF = { icon = '󰅒 ', alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
                    NOTE = { icon = ' ', color = 'hint', alt = { 'INFO' } },
                    TEST = { icon = '󰙨 ', color = 'hint', alt = { 'TESTING', 'TESTS' } },
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
                colors = {
                    error = { 'DiagnosticError', 'ErrorMsg', '#DC2626' },
                    warning = { 'DiagnosticWarning', 'WarningMsg', '#FBBF24' },
                    info = { 'DiagnosticInfo', '#2563EB' },
                    hint = { 'DiagnosticHint', '#10B981' },
                    default = { 'Identifier', '#7C3AED' },
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
            })
        end
    },
})
