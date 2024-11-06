require("blink.cmp").setup({
  opts = {
    keymap = {
      preset = "enter",
    },
    highlight = {
      use_nvim_cmp_as_default = true,
    },
    nerd_font_variant = "normal",
    accept = { auto_brackets = { enabled = true } },
    trigger = { signature_help = { enabled = true } },
  },
})
