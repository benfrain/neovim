return {
  keymap = {
    preset = "enter",
  },
  highlight = {
    use_nvim_cmp_as_default = true,
  },
  windows = {
    autocomplete = {
      draw = {
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
      },
    },
  },
  nerd_font_variant = "normal",
  accept = { auto_brackets = { enabled = true } },
  trigger = { signature_help = { enabled = true } },
}
