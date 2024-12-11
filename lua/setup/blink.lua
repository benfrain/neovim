return {
  keymap = {
    preset = "enter",
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    trigger = { signature_help = { enabled = true } },
    menu = {
      draw = {
        columns = { { "label", "label_description", gap = 2 }, { "kind_icon", "kind", gap = 2 } },
      },
    },
  },
}
