-- nvim-treesitter "main" branch API (the old configs.setup is gone).
-- Parsers are installed with require("nvim-treesitter").install — a no-op
-- when already present. Highlighting is Neovim's built-in vim.treesitter,
-- started per filetype below.

local parsers = {
  "c",
  "css",
  "scss",
  "typescript",
  "lua",
  "html",
  "javascript",
  "json",
  "php",
  "rust",
  "yaml",
  "vim",
  "toml",
  "markdown",
  "markdown_inline",
}

local ok, ts = pcall(require, "nvim-treesitter")
if ok then
  ts.setup({})
  ts.install(parsers)
end

-- Start treesitter highlighting for every installed language
vim.api.nvim_create_autocmd("FileType", {
  pattern = parsers,
  callback = function()
    -- only start if a parser actually exists for this filetype
    pcall(vim.treesitter.start)
  end,
})
