local indent = 4
local opt = vim.opt -- to set options
opt.backspace = { "indent", "eol", "start" }
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.cursorline = true
opt.cursorcolumn = true
opt.encoding = "utf-8" -- Set default encoding to UTF-8
opt.foldenable = true
opt.foldmethod = "manual"
-- opt.formatoptions = "l"
opt.hidden = true -- Enable background buffers
opt.hlsearch = true -- Highlight found searches
opt.ignorecase = true -- Ignore case
opt.inccommand = "split" -- Get a preview of replacements
opt.incsearch = true -- Shows the match while typing
opt.joinspaces = false -- No double spaces with join
vim.o.lazyredraw = true
opt.linebreak = true -- Stop words being broken on wrap
opt.number = true -- Show line numbers
opt.listchars = { tab = " ", trail = "·", nbsp = "%" }
opt.list = true -- Show some invisible characters
-- opt.relativenumber = true
vim.o.shortmess = vim.o.shortmess .. "S" -- stops display of currentsearch match in cmdline area
opt.equalalways = true -- make windows the same width when closing one
opt.cursorlineopt = "both" -- should get cursorline in number too

opt.expandtab = true
opt.shiftwidth = indent
opt.softtabstop = indent
opt.tabstop = indent

opt.showmode = false -- Don't display mode
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes:1" -- always show signcolumns
opt.smartcase = true -- Do not ignore case with capitals
opt.spelllang = { "en_gb" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
-- opt.splitkeep = "screen" -- Stops screen jumping when splits below are opened
opt.termguicolors = true -- You will have bad experience for diagnostic messages when it's default 4000.
opt.title = true -- Allows neovom to send the Terminal details of the current window, instead of just getting 'v'
-- Give me some fenced codeblock goodness
vim.g.markdown_fenced_languages = { "html", "javascript", "typescript", "css", "scss", "lua", "vim" }
vim.o.whichwrap = vim.o.whichwrap .. "<,>" -- Wrap movement between lines in edit mode with arrows
opt.wrap = true
-- opt.cc = "80"
opt.mouse = "a"
opt.guicursor =
  "n-v-c-sm:block-nCursor-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"
opt.undodir = vim.fn.stdpath("config") .. "/undo"
opt.undofile = true
-- vim.notify = require("notify")
opt.jumpoptions = "view"
opt.timeoutlen = 300 -- The time before a key sequence should complete
opt.cpoptions:append(">") -- when you yank multiple times into a register, this puts each on a new line
opt.nrformats:append("alpha") -- this means you can increment lists that have letters with `g ctrl-a`
-- opt.pumblend = 5 -- partial opacity of pop up menu, this causes characters in lspkind to render incorrect width and means that you have to set up kitty to use narrow symbols. See https://github.com/kovidgoyal/kitty/discussions/7774#discussioncomment-10442608
opt.ph = 15 -- the number is the number of entries to show before scrollbars, not px!
opt.cmdheight = 0
opt.virtualedit = "block" -- allows using visual blocks beyond the end of a line
vim.g.editorconfig = false -- disable editor config as VSCode does not have it on by default

local api = vim.api
-- Highlight on yank
local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  group = yankGrp,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight yank",
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = cursorGrp })
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- show cursor col line only in active window
local cursorColGrp = api.nvim_create_augroup("CursorColumn", { clear = true })
api.nvim_create_autocmd(
  { "InsertLeave", "WinEnter" },
  { pattern = "*", command = "set cursorcolumn", group = cursorColGrp }
)
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorcolumn", group = cursorColGrp }
)

-- show Blank Line only in active window
-- local blanklineGrp = api.nvim_create_augroup("BlankLine", { clear = true })
-- api.nvim_create_autocmd(
--   { "InsertLeave", "WinEnter" },
--   { pattern = "*", command = ":IndentBlanklineEnable", group = blanklineGrp }
-- )
-- api.nvim_create_autocmd(
--   { "InsertEnter", "WinLeave" },
--   { pattern = "*", command = ":IndentBlanklineDisable", group = blanklineGrp }
-- )

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- Don't want relative no on inactive Windows
-- local relativeNo = api.nvim_create_augroup("RelativeNo", { clear = true })
--
-- api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
--   pattern = "*",
--   group = relativeNo,
--   callback = function()
--     if not vim.g.zen_mode_active then
--       vim.cmd([[set relativenumber]])
--     end
--   end,
-- })
--
-- api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
--   pattern = "*",
--   group = relativeNo,
--   callback = function()
--     if not vim.g.zen_mode_active then
--       vim.cmd([[set norelativenumber]])
--     end
--   end,
-- })

-- This is global settings for diagnostics
vim.o.updatetime = 250
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  virtual_lines = {
    current_line = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰳦 ",
      [vim.diagnostic.severity.HINT] = "󱡄 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})
