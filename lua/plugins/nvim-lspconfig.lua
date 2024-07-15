return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/nvim-cmp',
    'hrsh7th/vim-vsnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'kdheepak/cmp-latex-symbols',
    'folke/lazydev.nvim',
    'onsails/lspkind.nvim',
  },
  lazy = false,
  init = function()
    vim.diagnostic.config({ virtual_text = true })
    vim.o.completeopt = 'menu,menuone,noselect'
    local cmp = require('cmp')
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = {
          border = 'single',
          scrollbar = false,
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
        },
      },
      formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 120 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"
          return kind
        end,
      },
      view = {
        entries = 'custom',
        docs = {
          auto_open = true
        }
      },
      mapping = {
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'lazydev' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'emoji' },
        { name = 'crates' },
        { name = 'latex_symbols', strategy = 1 },
      }),
    })
    -- cmp.setup.cmdline({ '/', '?' }, {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = { { name = 'buffer' } }
    -- })
    -- cmp.setup.cmdline(':', {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources(
    --     { { name = 'path' } }
    --     -- { { name = 'cmdline' } }
    --   )
    -- })
  end,
  config = function()
    local wk = require('which-key')
    local lsp = require('lspconfig')
    local on_attach = function(client, bufnr)
      vim.api.nvim_set_option_value('omnifunc', 'lua.lsp.omnifunc', { buf = bufnr })
      wk.register({
        ['<leader>rn'] = { '<CMD>lua vim.lsp.buf.rename()<CR>', 'Rename Symbol' },
        ['<leader>gr'] = { '<CMD>Telescope lsp_references<CR>', 'Goto References' },
        ['<leader>gd'] = { '<CMD>Telescope lsp_definitions<CR>', 'Goto Definitions' },
        ['<leader>gi'] = { '<CMD>Telescope lsp_implementations<CR>', 'Goto Implementations' },
      })
    end
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    local servers = {
      'tsserver',
      'cssls',
      'html',
      'pyright',
      'clangd',
      'lua_ls',
      'lazydev',
    }
    for _, server in ipairs(servers) do
      lsp[server].setup({
        on_attach = on_attach,
        capabilities = capabilities
      })
    end
  end
} 
