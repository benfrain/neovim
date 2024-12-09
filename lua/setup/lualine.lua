local mode_map = {
  ["NORMAL"] = "N",
  ["O-PENDING"] = "N?",
  ["INSERT"] = "I",
  ["VISUAL"] = "V",
  ["V-BLOCK"] = "VB",
  ["V-LINE"] = "VL",
  ["V-REPLACE"] = "VR",
  ["REPLACE"] = "R",
  ["COMMAND"] = "!",
  ["SHELL"] = "SH",
  ["TERMINAL"] = "T",
  ["EX"] = "X",
  ["S-BLOCK"] = "SB",
  ["S-LINE"] = "SL",
  ["SELECT"] = "S",
  ["CONFIRM"] = "Y?",
  ["MORE"] = "M",
}

-- stolen/amended from https://github.com/leonasdev/.dotfiles/blob/master/.config/nvim/lua/util/statusline.lua
local function getScrollPos()
  local progressIcons = {
    "󰋙 ",
    "󰫃 ",
    "󰫄 ",
    "󰫅 ",
    "󰫆 ",
    "󰫇 ",
    "󰫈 ",
  }
  local current = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_line_count(0)
  local i = math.floor((current - 1) / lines * #progressIcons) + 1
  local sbar = string.format(progressIcons[i])

  local colPre = "c"
  local col = "%c "

  return string.format("%s%s%s", colPre, col, sbar)
end

local function createDiffString()
  local diffparts = vim.b.gitsigns_status_dict
  local head = diffparts.head or "unknown"
  local head_and_icon = "󰘬 " .. head
  local added = diffparts.added or 0
  local removed = diffparts.removed or 0
  local changed = diffparts.changed or 0

  -- Start constructing the output string (thanks to fpohtmeh on Reddit for helping with this:https://www.reddit.com/r/neovim/comments/1h866d1/comment/m0sujbd/?context=3)
  local output = string.format("%%#lualine_b_normal#%s", head_and_icon)
  local hasChanges = false

  if added > 0 or removed > 0 or changed > 0 then
    output = output .. string.format("%%#lualine_b_normal#%s", "(")
    hasChanges = true
  end

  if added > 0 then
    output = output .. string.format("%%#lualine_b_diff_added_normal#+%d", added)
  end

  if removed > 0 then
    output = output .. string.format("%%#lualine_b_diff_removed_normal#-%d", removed)
  end

  if changed > 0 then
    output = output .. string.format("%%#lualine_b_diff_modified_normal#~%d", changed)
  end

  -- Close the parentheses if any changes were added
  if hasChanges then
    output = output .. string.format("%%#lualine_b_normal#%s", ")")
  end

  -- Return the final output
  return output
end

-- Make a global table
wordCount = {}
-- Now add a function to it for the job needed
function wordCount.getWords()
  if vim.bo.filetype == "md" or vim.bo.filetype == "txt" or vim.bo.filetype == "markdown" then
    if vim.fn.wordcount().visual_words == 1 then
      return tostring(vim.fn.wordcount().visual_words) .. " word"
    elseif not (vim.fn.wordcount().visual_words == nil) then
      return tostring(vim.fn.wordcount().visual_words) .. " words"
    else
      return tostring(vim.fn.wordcount().words) .. " words"
    end
  else
    return "Not a text file"
  end
end

--- @param trunc_width number trunctates component when screen width is less then trunc_width
--- @param trunc_len number truncates component to trunc_len number of chars
--- @param hide_width number hides component when window width is smaller then hide_width
--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
--- return function that can format the component accordingly
local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then
      return ""
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and "" or "...")
    end
    return str
  end
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function window()
  return vim.api.nvim_win_get_number(0)
end

-- adapted from https://www.reddit.com/r/neovim/comments/xy0tu1/cmdheight0_recording_macros_message/
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "󰑋  " .. recording_register
  end
end

-- print(vim.inspect(nfColors))
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { " ", " " },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = {
      -- { "mode", fmt = trunc(80, 1, nil, true) },
      {
        "mode",
        fmt = function(s)
          return mode_map[s] or s
        end,
      },
    },
    lualine_b = {
      {
        createDiffString,
        color = nil,
      },
    },
    lualine_c = {
      { "diagnostics", sources = { "nvim_diagnostic" }, draw_empty = false },
      function()
        return "%="
      end,
      {
        "filename",
        file_status = true,
        path = 0,
        shorting_target = 40,
        symbols = {
          modified = "󰐖 ", -- Text to show when the file is modified.
          readonly = " ", -- Text to show when the file is non-modifiable or readonly.
          unnamed = "[No Name]", -- Text to show for unnamed buffers.
          newfile = "[New]", -- Text to show for new created file before first writting
        },
      },
      {
        wordCount.getWords,
        color = { fg = "#333333", bg = "#eeeeee" },
        separator = { left = "", right = "" },
        cond = function()
          return wordCount.getWords() ~= "Not a text file"
        end,
      },
      {
        "searchcount",
      },
      {
        "selectioncount",
      },
      {
        show_macro_recording,
        color = { fg = "#333333", bg = "#ff6666" },
        separator = { left = "", right = "" },
      },
    },
    lualine_y = {
      nil,
    },
    lualine_x = {
      { getScrollPos, width = 100, padding = { left = 10, right = 1 } },
    },
    lualine_z = { nil },
  },
  inactive_sections = {
    lualine_a = { { window, color = { fg = "#26ffbb", bg = "#282828" } } },
    lualine_b = {
      {
        "diff",
        source = diff_source,
        color_added = "#a7c080",
        color_modified = "#ffdf1b",
        color_removed = "#ff6666",
      },
    },
    lualine_c = {
      function()
        return "%="
      end,
      {
        "filename",
        path = 1,
        shorting_target = 40,
        symbols = {
          modified = "󰐖 ", -- Text to show when the file is modified.
          readonly = " ", -- Text to show when the file is non-modifiable or readonly.
          unnamed = "[No Name]", -- Text to show for unnamed buffers.
          newfile = "[New]", -- Text to show for new created file before first writting
        },
      },
    },
    lualine_x = {
      { place, padding = { left = 1, right = 1 } },
    },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "quickfix",
    "oil",
    "fzf",
  },
})

local lualine = require("lualine")
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    lualine.refresh()
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    -- This is going to seem really weird!
    -- Instead of just calling refresh we need to wait a moment because of the nature of
    -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
    -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
    -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
    -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
    local timer = vim.loop.new_timer()
    timer:start(
      50,
      0,
      vim.schedule_wrap(function()
        lualine.refresh()
      end)
    )
  end,
})
