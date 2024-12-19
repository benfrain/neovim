return {
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  indent = {
    enabled = true,
    char = "▎",
    animate = { enabled = false },
    indent = {
      only_current = true,
      only_scope = true,
    },
    scope = {
      enabled = true,
      only_current = true,
      only_scope = true,
      underline = false,
    },
    chunk = {
      enabled = true,
      only_current = true,
    },
    -- filter for buffers, turn off the indents for markdown
    filter = function(buf)
      return vim.g.snacks_indent ~= false
        and vim.b[buf].snacks_indent ~= false
        and vim.bo[buf].buftype == ""
        and vim.bo[buf].filetype ~= "markdown"
    end,
  },
  input = { enabled = true },
  notifier = {
    enabled = true,
    win = {
      backdrop = {
        transparent = false,
      },
    },
  },
  quickfile = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  words = { enabled = false },
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
    toggles = {
      dim = false,
    },
    win = {},
    show = {
      statusline = false,
      tabline = false,
    },
  },
  styles = {
    zen = {
      backdrop = {
        transparent = false,
      },
      width = 100,
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
