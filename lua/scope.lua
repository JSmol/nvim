require('telescope').setup({
  defaults = {
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

    }
  },
  pickers = {
    find_files = { theme = "ivy"},
    help_tags = { theme = "ivy" },
    buffers = { theme = "ivy" },
    treesitter = { },
    git_stash = { },
    git_status = { },
    git_branches = { },
    git_branches = { },
    -- lsp_references = { theme = 'cursor' },
    -- lsp_definitions = { theme = 'cursor' },
  },
})

