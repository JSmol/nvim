vim.diagnostic.config({ virtual_text = true })

-- cmp setup
vim.o.completeopt = 'menu,menuone,noselect'
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }, {i, s}),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }, {i, s}),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ['<C-l>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
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
        { { name = 'path' } },
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
        'bash', 'c', 'cmake', 'comment', 'cpp', 'css', 'csv', 'diff', 
        'dockerfile', 'glsl', 'haskell', 'html', 'javascript',
        'jq', 'json', 'julia', 'latex', 'llvm', 'lua', 'make', 'markdown', 
        'mlir', 'nix', 'printf', 'python', 'rust', 
        'tablegen', 'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
    },
})

-- lsp config
local wk = require('which-key')
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.lsp.omnifunc')
    wk.register({
        ['<leader>rn'] = { '<CMD>lua vim.lsp.buf.rename()<CR>', 'Rename Symbol' },
        ['<leader>gr'] = { '<CMD>Telescope lsp_references<CR>', 'Goto References' },
        ['<leader>gd'] = { '<CMD>Telescope lsp_definitions<CR>', 'Goto Definitions' },
        ['<leader>gi'] = { '<CMD>Telescope lsp_implementations<CR>', 'Goto Implementations' },
    })
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = {
    "tsserver",
    "cssls",
    "html",
    "pyright",
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
            on_attach(client, bufnr)
            wk.register({
                ['<C-k>'] = { rt.hover_actions.hover_actions, 'Hover', buffer = bufnr },
                ['<C-/>'] = { rt.code_action_group.code_action_group, 'Coda Actions', buffer = bufnr },
            })
        end,
    },
})

