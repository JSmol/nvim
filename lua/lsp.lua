-- LSP AND COMPLETION

vim.diagnostic.config({ virtual_text = false })

-- cmp setup
vim.o.completeopt = "menu,menuone,noselect"
local cmp = require("cmp")
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }, {i, s}),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }, {i, s}),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'emoji' },
        { name = 'crates' },
        { name = 'latex_symbols', strategy = 1 },
    }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        -- { { name = 'path' } },
        { { name = 'cmdline' } }
    )
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

-- setup nvim_lsp source --
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('nvim-treesitter.configs').setup({
    ensure_installed = { 
        'typescript',
        'javascript',
        'markdown',
        'comment',
        'lua',
        'python',
        'html',
        'css',
        'c',
        'rust' 
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
    },
})

-- lsp config
local wk = require('which-key')
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    wk.register({
        ['<leader>ha'] = { '<CMD>lua vim.lsp.buf.hover()<CR>', 'Hover' },
        ['<leader>rn'] = { '<CMD>lua vim.lsp.buf.rename()<CR>', 'Rename Symbol' },
        ['<leader>gr'] = { '<CMD>Telescope lsp_references<CR>', 'Goto References' },
        ['<leader>gd'] = { '<CMD>Telescope lsp_definitions<CR>', 'Goto Definitions' },
    })
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = {
    "tsserver",
    "pyright",
    "cssls",
    "html",
    "clangd",
}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities
    })
end

-- Rust Tools --
local rt = require("rust-tools")
rt.setup({
    server = {
        on_attach = function(client, bufnr)
            -- local opts = { noremap=true, silent=true }
            wk.register({
                ['<leader>ha'] = { rt.hover_actions.hover_actions, 'Hover', buffer = bufnr },
                ['<leader>rn'] = { '<CMD>lua vim.lsp.buf.rename()<CR>', 'Rename Symbol' },
                ['<leader>gr'] = { '<CMD>Telescope lsp_references<CR>', 'Goto References' },
                ['<leader>gd'] = { '<CMD>Telescope lsp_definitions<CR>', 'Goto Definitions' },
                ['<leader>ca'] = { rt.code_action_group.code_action_group, 'Coda Actions', buffer = bufnr },
            })
        end,
    },
})

