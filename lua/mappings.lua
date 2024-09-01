local km = vim.keymap

-- Here is a utility function that closes any floating windows when you press escape
local function close_floating()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

--  ┌                                                                              ┐
--  │ These define common comment styles like this                                 │
--  └                                                                              ┘
km.set({ "n", "v" }, "<leader>x1", ":CBlbox12<cr>", { desc = "Comment - single side" })
km.set({ "n", "v" }, "<leader>x2", ":CBlbox18<cr>", { desc = "Comment - both sides" })
km.set("n", "<leader>x3", "CBline3<cr>", { desc = "Centered Line" })
km.set("n", "<leader>x4", "CBline5<cr>", { desc = "Centered Line Weighted" })

km.set("n", "<Leader>u", ":Lazy update<CR>", { desc = "Lazy Update (Sync)" })

km.set("n", "<Leader>n", "<cmd>enew<CR>", { desc = "New File" })

km.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })

-- Make visual yanks place the cursor back where started
km.set("v", "y", "ygv<Esc>", { desc = "Yank and reposition cursor" })

km.set("n", "<Delete>", "<cmd>:w<CR>", { desc = "Save file" })

km.set("n", "<leader>xu", ":UndotreeToggle<cr>", { desc = "Undo Tree" })
-- More molecular undo of text
km.set("i", ".", ".<c-g>u")
km.set("i", "!", "!<c-g>u")
km.set("i", "?", "?<c-g>u")
km.set("i", ";", ";<c-g>u")
km.set("i", ":", ":<c-g>u")

km.set({ "n", "i" }, "<F1>", "<Esc>")

--nav buddy
km.set({ "n" }, "<leader>xb", ":lua require('nvim-navbuddy').open()<cr>", { desc = "Nav Buddy" })

km.set("n", "<esc>", function()
  close_floating()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

km.set("n", "<leader>l", ":LazyGit<cr>", { silent = true, desc = "Lazygit" })

-- Easy delete buffer without losing window split
km.set("n", "<leader>d", ":lua MiniBufremove.delete()<cr>", { silent = true, desc = "Mini Bufremove" })

-- Easy add date/time
function date()
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. "# " .. os.date("%d.%m.%y") .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_feedkeys("o", "n", true)
end

km.set("n", "<Leader>xd", "<cmd>lua date()<cr>", { desc = "Insert Date" })

km.set("n", "<Leader>v", "gea", { desc = "Edit after last word" })

km.set("n", "j", [[(v:count > 5 ? "m'" . v:count : "") . 'j']], { expr = true, desc = "if j > 5 add to jumplist" })

km.set("n", "<leader>p", require("fzf-lua").files, { desc = "Fzf Files" })

km.set("n", "<leader>r", require("fzf-lua").registers, { desc = "Registers" })

km.set("n", "<leader>m", require("fzf-lua").marks, { desc = "Marks" })

km.set("n", "<leader>f", require("fzf-lua").live_grep, { desc = "Fzf Grep" })

km.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "Fzf Buffers" })

km.set("n", "<leader>j", require("fzf-lua").helptags, { desc = "Help Tags" })

km.set("n", "<leader>gc", require("fzf-lua").git_bcommits, { desc = "Browse File Commits" })

km.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })

km.set("n", "<leader>s", require("fzf-lua").spell_suggest, { desc = "Spelling Suggestions" })

km.set("n", "<leader>cj", require("fzf-lua").lsp_definitions, { desc = "Jump to Definition" })

km.set(
  "n",
  "<leader>cs",
  ":lua require'fzf-lua'.lsp_document_symbols({winopts = {preview={wrap='wrap'}}})<cr>",
  { desc = "Document Symbols" }
)

km.set("n", "<leader>cr", require("fzf-lua").lsp_references, { desc = "LSP References" })

km.set(
  "n",
  "<leader>cd",
  ":lua require'fzf-lua'.diagnostics_document({fzf_opts = { ['--wrap'] = true }})<cr>",
  { desc = "Document Diagnostics" }
)

-- Built in LSP stuff
-- km.set("n", "<leader>ca", function()
--   vim.lsp.buf.code_action()
-- end, { desc = "Code Actions" })

km.set(
  "n",
  "<leader>ca",
  ":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<cr>",
  { desc = "Code Actions" }
)

km.set("n", "<leader>ch", function()
  vim.lsp.buf.hover()
end, { desc = "Code Hover" })

km.set("n", "<leader>cl", function()
  vim.diagnostic.open_float(0, { scope = "line" })
end, { desc = "Line Diagnostics" })

km.set({ "v", "n" }, "<leader>cn", function()
  vim.lsp.buf.rename()
end, { noremap = true, silent = true, desc = "Code Rename" })

km.set("n", "<Leader><Down>", "<C-W><C-J>", { silent = true, desc = "Window Down" })
km.set("n", "<Leader><Up>", "<C-W><C-K>", { silent = true, desc = "Window Up" })
km.set("n", "<Leader><Right>", "<C-W><C-L>", { silent = true, desc = "Window Right" })
km.set("n", "<Leader><Left>", "<C-W><C-H>", { silent = true, desc = "Window Left" })
km.set("n", "<Leader>wr", "<C-W>R", { silent = true, desc = "Window Resize" })
km.set("n", "<Leader>=", "<C-W>=", { silent = true, desc = "Window Equalise" })

-- Easier window switching with leader + Number
-- Creates mappings like this: km.set("n", "<Leader>2", "2<C-W>w", { desc = "Move to Window 2" })
for i = 1, 4 do
  local lhs = "<Leader>" .. i
  local rhs = i .. "<C-W>w"
  km.set("n", lhs, rhs, { desc = "Move to Window " .. i })
end

km.set({ "n", "v" }, "h", ":Pounce<CR>", { silent = true, desc = "Pounce" })
km.set("n", "H", ":PounceRepeat<CR>", { silent = true, desc = "Pounce Repeat" })

-- thanks to https://www.reddit.com/r/neovim/comments/107g7yf/comment/j3o5a6f/?context=3 we can toggle the line mode changes in our options due to the correct variable being set here
km.set("n", "<leader>z", function()
  if vim.g.zen_mode_active then
    require("zen-mode").toggle()
    vim.g.zen_mode_active = false
  else
    require("zen-mode").toggle()
    vim.g.zen_mode_active = true
  end
end, { desc = "Zen Mode Toggle" })

km.set("i", "<A-BS>", "<C-W>", { desc = "Option+BS deletes whole word" })

-- Gitsigns specific for file specific git info/tools
km.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<cr>", { desc = "Git toggle line blame" })
km.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { desc = "Git preview hunk" })
km.set("n", "<leader>gr", ":Gitsigns reset_hunk<cr>", { desc = "Get reset hunk" })

km.set("n", "<Leader>xs", ":SearchSession<CR>", { desc = "Search Sessions" })

km.set(
  "v",
  "<leader>xp",
  ":'<,'> w !pandoc --no-highlight --wrap=none | pbcopy <CR>",
  { silent = true, desc = "Pandoc Export" }
)

km.set("n", "<Leader>xn", ":let @+=@%<cr>", { desc = "Copy Buffer name and path" })

km.set("n", "<Leader>xc", ":g/console.lo/d<cr>", { desc = "Remove console.log" })

km.set("v", "<leader>o", "zA", { desc = "Toggle Fold" })

km.set({ "n", "x" }, "[p", '<Cmd>exe "put! " . v:register<CR>', { desc = "Paste Above" })
km.set({ "n", "x" }, "]p", '<Cmd>exe "put "  . v:register<CR>', { desc = "Paste Below" })

-- This allows you to select, and paste over contents, without that pasted over contents going into the register, that means you can paste again without it inserting the thing you pasted over the last time
km.set("x", "p", function()
  return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

km.set({ "n", "x" }, "<Bslash>", "<C-6>", { desc = "Alternate File" })
km.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- This sets the ability to surround words with brackets and quotes with one key in visual mode
-- local v_chars = { "(", ")", "[", "]", "{", "}", "'", '"' }
-- for _, char in pairs(v_chars) do
--   vim.keymap.set("v", char, "<Plug>(nvim-surround-visual)" .. char)
-- end
--
-- Set file EOL
km.set({ "n" }, "<Leader>xl", ":set ff=dos<CR>", { desc = "EOL = CRLF" })
km.set({ "n" }, "<Leader>xf", ":set ff=unix<CR>", { desc = "EOL = LF" })
