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
      return vim.bo.filetype == "markdown" and 2 or 0
    end,
  },
  completion = {
    documentation = { window = { border = "single" } },
    menu = {
      border = "single",
    },
    ghost_text = { enabled = true },
    list = {
      selection = function(ctx)
        return ctx.mode == "cmdline" and "auto_insert" or "preselect"
      end,
    },
  },
  signature = { window = { border = "single" } },
}
