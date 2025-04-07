-- Hey Ben, you always forget this! When you want to search for something literal, say 'url(' you can use this:
-- `url( -- -F` in the search box. Everything after the double dash is the option you are passing to FZF and in this case that would be Fixed String (and not trying to parse as a regex)
local path = require("fzf-lua.path")
get_line_and_path = function(selected, opts)
  local file_and_path = path.entry_to_file(selected[1], opts).stripped
  vim.print(file_and_path)
  if vim.o.clipboard == "unnamed" then
    vim.fn.setreg([[*]], file_and_path)
  elseif vim.o.clipboard == "unnamedplus" then
    vim.fn.setreg([[+]], file_and_path)
  else
    vim.fn.setreg([["]], file_and_path)
  end
  -- copy to the yank register regardless
  vim.fn.setreg([[0]], file_and_path)
end

require("fzf-lua").setup({
  "border-fused",
  fzf_opts = { ["--wrap"] = true },
  previewers = {
    builtin = {
      syntax_limit_b = -102400, -- 100KB limit on highlighting files
    },
  },
  winopts = {
    preview = {
      wrap = true,
    },
  },
  grep = {
    rg_glob = true,
    -- first returned string is the new search query
    -- second returned string are (optional) additional rg flags
    -- @return string, string?
    rg_glob_fn = function(query, opts)
      local regex, flags = query:match("^(.-)%s%-%-(.*)$")
      -- If no separator is detected will return the original query
      return (regex or query), flags
    end,
  },
  defaults = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
    formatter = "path.filename_first",
  },
  actions = {
    files = {
      true,
      ["ctrl-y"] = { fn = get_line_and_path, exec_silent = true },
    },
  },
})
