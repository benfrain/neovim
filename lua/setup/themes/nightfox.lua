-- Nightfox config
local nightfox = require("nightfox")
nightfox.setup({
  options = {
    dim_inactive = true,
    styles = {
      comments = "italic",
      keywords = "bold",
      functions = "italic,bold",
    },
    inverse = {
      search = true,
      match_paren = true,
    },
  },
  groups = {
    all = {
      CursorLine = { bg = "#353A54" },
      CursorColumn = { bg = "#353A54" },
    },
  },
})

vim.cmd("colorscheme duskfox") -- Put your favorite colorscheme here
