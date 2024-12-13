return {
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  indent = {
    enabled = true,
    char = "▎",
    only_scope = true,
    only_current = true,
    scope = { animate = { enabled = false } },
  },
  input = { enabled = true },
  notifier = { enabled = true, win = {
    backdrop = {
      transparent = false,
    },
  } },
  quickfile = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  toggle = {
    which_key = true, -- integrate with which-key to show enabled/disabled icons and colors
    notify = true, -- show a notification when toggling
    -- icons for enabled/disabled states
    icon = {
      enabled = " ",
      disabled = " ",
    },
    -- colors for enabled/disabled states
    color = {
      enabled = "green",
      disabled = "yellow",
    },
  },
  zen = {
    minimal = true,
    win = {
      backdrop = {
        transparent = false,
      },
    },
  },
  styles = {
    zen = {
      wo = {
        number = false,
        signcolumn = "no",
        cursorcolumn = false,
        relativenumber = false,
      },
    },
    notification = {
      wo = {
        spell = false,
        winblend = 0,
      },
    },
  },
}
