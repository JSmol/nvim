-- FZF / SEARCH
require('telescope').setup{
  defaults = {
    file_ignore_patterns = {

      -- js
      "node_modules",

      -- latex
      "%.pdf",
      "%.fls",
      "%.aux",
      "%.log",
      "%.fdb_latexmk",
      "%.synctex.gz",

      -- python
      "env",
      "media",
      "typings",
      "__pycache__",

      -- rust
      "target",

      "Images"
    }
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
    },
    help_tags = {
      theme = "ivy",
    }
  },
}


