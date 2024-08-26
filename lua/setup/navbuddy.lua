local navbuddy = require("nvim-navbuddy")
local actions = require("nvim-navbuddy.actions")

navbuddy.setup({
  window = {
    border = "double",
  },
  mappings = {
    ["<Down>"] = actions.next_sibling(), -- down
    ["<Up>"] = actions.previous_sibling(), -- up
    ["<Left>"] = actions.parent(), -- Move to left panel
    ["<Right>"] = actions.children(), -- Move to right panel
    ["<PageDown>"] = actions.root(), -- Move to first panel
  },
  lsp = {
    auto_attach = true,
  },
})
