require("fzf-lua").setup({
  fzf_opts = { ["--wrap"] = true },
  grep = { rg_glob = true },
  winopts = {
    preview = {
      wrap = "wrap",
    },
  },
  defaults = {
    git_icons = false,
    file_icons = false,
    color_icons = false,
    formatter = "path.filename_first",
  },
})
