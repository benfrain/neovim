return {
  keymap = {
    preset = "enter",
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    min_keyword_length = function()
      return vim.bo.filetype == "markdown" and 4 or 0
    end,
    providers = {
      lsp = {
        fallbacks = {},
      },
    },
  },
  completion = {
    documentation = { window = { border = "single" } },
    menu = {
      border = "single",
    },
    -- ghost_text = { enabled = true },
    list = {
      selection = {
        preselect = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
        auto_insert = function(ctx)
          return ctx.mode ~= "cmdline"
        end,
      },
    },
  },
  signature = { window = { border = "single" } },
}
