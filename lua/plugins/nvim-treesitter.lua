return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash',
        'c',
        'comment',
        'cpp',
        'css',
        'csv',
        'diff',
        'glsl',
        'haskell',
        'html',
        'javascript',
        'jq',
        'json',
        'latex',
        'llvm',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'rust',
        'tablegen',
        'toml',
        'tsx',
        'typescript',
        'vim',
      },
      ignore_install = {},
      modules = {},
      auto_install = false,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = true,
        module_path = "nvim-treesitter.highlight"
      },
      incremental_selection = {
        -- TODO: Learn this cause it seems useful.
        enable = false,
      },
      indent = {
        enable = true,
        module_path = "nvim-treesitter.indent"
      },
      sync_install = true
    })
  end
}
