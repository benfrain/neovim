require("which-key").setup({
  preset = "helix",
  delay = 0,
  win = {
    height = {
      max = math.huge,
    },
  },
  plugins = {
    spelling = {
      enabled = false,
    },
  },
  icons = {
    rules = false,
    breadcrumb = " ", -- symbol used in the command line area that shows your active key combo
    separator = "󱦰  ", -- symbol used between a key and it's label
    group = "󰹍 ", -- symbol prepended to a group
  },
})
