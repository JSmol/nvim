return {

  'neovim/nvim-lspconfig',

  dependencies = { {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'moyiz/blink-emoji.nvim',
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } }
        }
      },
    },
    -- If you use nix, you can build from source using latest nightly rust with:
    build = 'nix run .#build-plugin',
    version = '*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'enter',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        cmdline = {
          preset = 'default',
          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<C-j>'] = { 'select_next', 'fallback' },
        }
      },
      completion = { ghost_text = { enabled = false } },
      signature = { enabled = true },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'emoji', 'lazydev' },
        providers = {
          emoji = { module = 'blink-emoji', name = 'Emoji', score_offset = 5 },
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink', score_offset = 100 },
        }
      },
    },
    opts_extend = { 'sources.default' }
  } },

  init = function()
    vim.diagnostic.config({ virtual_text = true })
    vim.o.completeopt = 'menu,menuone,noselect'
  end,

  opts = {
    servers = {
      clangd = {
        cmd = { 'clangd', '--background-index', '--log=error', '--clang-tidy', '--inlay-hints=true' },
      },
      ts_ls = {},
      cssls = {},
      html = {},
      nixd = {},
      lua_ls = {},
      pyright = {},
      rust_analyzer = {},
    }
  },

  config = function(_, opts)
    local lsp = require('lspconfig')
    local servers = opts.servers
    for server, config in pairs(servers) do
      local server_options = vim.tbl_deep_extend('keep', config, {
        on_attach = function(client, bufnr)
          vim.api.nvim_set_option_value('omnifunc', 'lua.lsp.omnifunc', { buf = bufnr })
          if client.supports_method('textDocument/inlayHint', { bufnr = bufnr }) then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, id = client.id })
              end
            })
          end
        end,
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })
      lsp[server].setup(server_options)
    end
  end

}
