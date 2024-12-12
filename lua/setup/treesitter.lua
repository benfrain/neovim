require("nvim-treesitter.configs").setup({
  autotag = {
    enable = true,
    filetypes = {
      "html",
      "javascript",
      "typescript",
      "markdown",
    },
  },
  ensure_installed = {
    "c",
    "css",
    "scss",
    "typescript",
    "lua",
    "html",
    "javascript",
    "json",
    "php",
    "rust",
    "yaml",
    "vim",
    "toml",
  },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<TAB>",
    },
  },
})
