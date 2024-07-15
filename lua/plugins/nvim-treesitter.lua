return {
  'nvim-treesitter/nvim-treesitter',
  opts = {
  },
  config = function()

    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash', 'c', 'comment', 'cpp', 'css', 'csv', 'diff', 'glsl', 'haskell', 'html',
        'javascript', 'jq', 'json', 'latex', 'llvm', 'lua', 'markdown', 'markdown_inline',
        'vim', 'vimdoc', 'python', 'rust', 'tablegen', 'toml', 'tsx', 'typescript',
      },
      auto_install = true,
      highlight = {
        additional_vim_regex_highlighting = true,
        enable = true,
        module_path = "nvim-treesitter.highlight"
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_decremental = "grm",
          node_incremental = "grn",
          scope_incremental = "grc"
        },
        module_path = "nvim-treesitter.incremental_selection"
      },
      indent = {
        enable = true,
        module_path = "nvim-treesitter.indent"
      },
      sync_install = true
    })
  end
}
