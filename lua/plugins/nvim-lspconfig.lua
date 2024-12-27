return {

  'neovim/nvim-lspconfig',

  dependencies = {
    {
      'saghen/blink.cmp',
      dependencies = {
        'rafamadriz/friendly-snippets',
        'moyiz/blink-emoji.nvim',
        {
          'folke/lazydev.nvim',
          ft = 'lua',
          opts = {
            library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } }, }
          }
        },
      },
      -- If you use nix, you can build from source using latest nightly rust with:
      build = 'nix run .#build-plugin',
      version = '*',
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        -- See the full "keymap" documentation for information on defining your own keymap.
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
        completion = {
          ghost_text = { enabled = false },
        },
        signature = { enabled = true },
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = 'mono'
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer', 'emoji', 'lazydev' },
          providers = {
            emoji = {
              module = 'blink-emoji',
              name = 'Emoji',
              score_offset = 5,
            },
            lazydev = {
              name = 'LazyDev',
              module = 'lazydev.integrations.blink',
              score_offset = 100,
            },
          }
        },
      },
      opts_extend = { 'sources.default' }
    },
  },

  init = function()
    vim.diagnostic.config({ virtual_text = true })
    vim.o.completeopt = 'menu,menuone,noselect'
  end,

  config = function()
    local wk = require('which-key')
    local lsp = require('lspconfig')
    local servers = {
      'ts_ls',
      'cssls',
      'html',
      'pyright',
      'clangd',
      'nixd',
      'lua_ls',
    }
    for _, server in ipairs(servers) do
      lsp[server].setup({
        on_attach = function(_, bufnr)
          vim.api.nvim_set_option_value('omnifunc', 'lua.lsp.omnifunc', { buf = bufnr })
          wk.add({
            { '<leader>a',  vim.lsp.buf.code_action, desc = 'Code Action' },
            { '<leader>rn', vim.lsp.buf.rename,      desc = 'Rename Symbol' },
          })
        end,
        capabilities = require('blink.cmp').get_lsp_capabilities()
      })
    end
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then return end
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = args.buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end
          })
        end
      end
    })
  end

}
