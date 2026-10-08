-- Polyfill for modules dropped in the nvim-treesitter "main" rewrite.
-- Only incremental_selection is enabled; other modules stay off.
require("treesitter-modules").setup({
  incremental_selection = {
    enable = true,
    keymaps = {
      -- restore the keymaps from the old nvim-treesitter config
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<CR>",
      node_decremental = "<TAB>",
    },
  },
})
