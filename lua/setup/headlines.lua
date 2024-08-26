vim.cmd([[highlight Headline1 guibg=#2C2F44 guifg=#BDCDF5]])
vim.cmd([[highlight Headline2 guibg=#2A2C41 guifg=#9EB6F0]])
vim.cmd([[highlight Headline3 guibg=#282A3E guifg=#91ACEE]])
vim.cmd([[highlight CodeBlock guibg=#2C2F44]])
vim.cmd([[highlight Dash guibg=#D19A66 gui=bold]])
require("headlines").setup({
  markdown = {
    headline_highlights = {
      "Headline1",
      "Headline2",
      "Headline3",
    },
  },
})
