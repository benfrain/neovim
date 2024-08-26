require("kanagawa").setup({
  compile = true,
  dimInactive = true,
  overrides = function(colors)
    local theme = colors.theme
    local palette = colors.palette
    return {

      IndentBlanklineChar = { fg = palette.waveBlue2 },
      MiniIndentscopeSymbol = { fg = palette.waveBlue2 },
      PmenuSel = { blend = 0 },
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },
      CursorLineNr = { bg = theme.ui.bg_p2 },
      Visual = { bg = palette.waveBlue2 },

      -- Save an hlgroup with dark background and dimmed foreground
      -- so that you can use it where your still want darker windows.
      -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
      NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

      -- Popular plugins that open floats will link to NormalFloat by default;
      -- set their background accordingly if you wish to keep them dark and borderless
      LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
    }
  end,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
})

require("kanagawa").load("wave")
