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
    { name = 'emoji' },
    { name = 'crates' },
    { name = 'latex_symbols', strategy = 1 },
  }),
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- setup nvim_lsp source
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('nvim-treesitter.configs').setup({
  ensure_installed = {'c', 'typescript', 'javascript', 'lua', 'python', 'html', 'css', 'comment', 'rust'},
  highlight = {
    enable = true,
  },
})

-- lsp config
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = { noremap=true, silent=true }
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  buf_set_keymap('n', '<F1>', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<F8>', '<Cmd>Telescope lsp_references<CR>', opts)
  buf_set_keymap('n', '<F12>', '<cmd>Telescope lsp_definitions<CR>', opts)
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { 
  "tsserver",
  "pyright",
  "cssls",
  "html",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities
  })
end

-- Rust Tools...
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      local opts = { noremap=true, silent=true }
      vim.keymap.set('n', '<F1>', rt.hover_actions.hover_actions, { buffer = bufnr })
      vim.keymap.set('n', '<F2>', '<CMD>lua vim.lsp.buf.rename()<CR>', opts)
      vim.keymap.set('n', '<F8>', '<Cmd>Telescope lsp_references<CR>', opts)
      vim.keymap.set('n', '<F12>', '<Cmd>Telescope lsp_definitions<CR>', opts)
      -- Code action groups
      vim.keymap.set("n", "<Leader>ac", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

