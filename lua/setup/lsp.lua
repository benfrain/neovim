local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Give me rounded borders everywhere
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- LSP Server config
require("lspconfig").cssls.setup({
  capabilities = capabilities,
  settings = {
    css = {
      lint = {
        emptyRules = "ignore",
        duplicateProperties = "warning",
      },
    },
    scss = {
      lint = {
        idSelector = "warning",
        zeroUnits = "warning",
        duplicateProperties = "warning",
        emptyRules = nil,
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    },
  },
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})
require("lspconfig").ts_ls.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

require("lspconfig").html.setup({
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

require("lspconfig").stylelint_lsp.setup({
  filetypes = { "css", "scss" },
  root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
  settings = {
    stylelintplus = {
      -- see available options in stylelint-lsp documentation
    },
  },
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
  end,
})

-- require("lspconfig").eslint.setup({
--   root_dir = require("lspconfig").util.root_pattern("package.json", ".git"),
--   on_attach = function(client)
--     client.server_capabilities.document_formatting = false
--   end,
-- })

-- LSP Prevents inline buffer annotations
vim.diagnostic.open_float()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  update_on_insert = false,
})
