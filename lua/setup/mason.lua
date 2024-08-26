require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "cssls",
    "tsserver",
    "stylua",
    "html",
  },
  automatic_installation = true,
})
