-- Telescope Global remapping
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local fb_actions = require("telescope._extensions.file_browser.actions")

--- Insert filename into the current buffer and keeping the insert mode.
actions.insert_name_i = function(prompt_bufnr)
  local symbol = action_state.get_selected_entry().ordinal
  actions.close(prompt_bufnr)
  vim.schedule(function()
    vim.cmd([[startinsert]])
    vim.api.nvim_put({ symbol }, "", true, true)
  end)
end

--- Insert file path and name into the current buffer and keeping the insert mode.
actions.insert_name_and_path_i = function(prompt_bufnr)
  local symbol = action_state.get_selected_entry().value
  actions.close(prompt_bufnr)
  vim.schedule(function()
    vim.cmd([[startinsert]])
    vim.api.nvim_put({ symbol }, "", true, true)
  end)
end

require("telescope").setup({
  defaults = {
    sorting_strategy = "descending",
    prompt_prefix = "   ",
    winblend = 25,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hidden = true,
      path = "%:p:h",
      mappings = {
        ["i"] = {
          ["<S-M>"] = fb_actions.move,
          ["<C-G>"] = fb_actions.goto_parent_dir,
          ["<C-Y>"] = actions.insert_name_i,
          ["<C-P>"] = actions.insert_name_and_path_i,
        },
      },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
      find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
      sort_mru = true,
      ignore_current_buffer = true,
      mappings = {
        i = {
          ["<C-w>"] = "delete_buffer",
        },
        n = {
          ["<C-w>"] = "delete_buffer",
        },
      },
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
