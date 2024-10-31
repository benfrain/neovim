-- returns the require for use in `config` parameter of lazy's use
-- expects the name of the config file
function get_setup(name)
  return function()
    require("setup." .. name)
  end
end

return {
  { "kdheepak/lazygit.nvim" },
  { "kyazdani42/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim" },
  { "rebelot/kanagawa.nvim", config = get_setup("themes/kanagawa"), priority = 1000, lazy = false },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
  { "stevearc/oil.nvim", event = "VeryLazy", config = get_setup("oil") },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = get_setup("conform"),
  },
  { "mbbill/undotree" },
  { "LudoPinelli/comment-box.nvim", event = "VeryLazy" },
  { "numToStr/Comment.nvim", lazy = false, config = get_setup("Comment") },
  { "rlane/pounce.nvim", config = get_setup("pounce") },
  {
    "nvim-lualine/lualine.nvim",
    config = get_setup("lualine"),
    event = "VeryLazy",
  },
  {
    "folke/zen-mode.nvim",
    config = get_setup("zen-mode"),
    event = "VeryLazy",
  },
  {
    "folke/which-key.nvim",
    config = get_setup("which-key"),
    event = "VeryLazy",
  },
  { "brenoprata10/nvim-highlight-colors", config = get_setup("highlight-colors") },
  {
    "nvim-treesitter/nvim-treesitter",
    config = get_setup("treesitter"),
    build = ":TSUpdate",
    event = "BufReadPost",
  },
  { "rcarriga/nvim-notify" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip-integ" },
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "rafamadriz/friendly-snippets" },
      { "onsails/lspkind.nvim" },
    },
    config = get_setup("cmp"),
    event = "InsertEnter",
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = get_setup("gitsigns"),
  },
  { "bennypowers/nvim-ts-autotag", branch = "template-tags", event = "InsertEnter" },
  {
    "neovim/nvim-lspconfig",
    config = get_setup("lsp"),
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = get_setup("fzf"),
  },
  { "rmagatti/auto-session", config = get_setup("auto-session") },
  { "echasnovski/mini.ai", config = get_setup("mini-ai"), version = false },
  { "echasnovski/mini.bracketed", config = get_setup("mini-bracketed"), version = false },
  { "echasnovski/mini.bufremove", config = get_setup("mini-bufremove"), version = false },
  { "echasnovski/mini.indentscope", config = get_setup("mini-indentscope"), version = false, event = "VeryLazy" },
  { "echasnovski/mini.move", config = get_setup("mini-move"), version = false },
  {
    "windwp/nvim-autopairs",
    config = get_setup("autopairs"),
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "rmagatti/session-lens",
    dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = get_setup("session"),
    enabled = false,
  },
  { "goolord/alpha-nvim", config = get_setup("alpha"), enabled = false },
  {
    "gen740/SmoothCursor.nvim",
    config = get_setup("smoothcursor"),
    enabled = false,
  },
  { "EdenEast/nightfox.nvim", config = get_setup("nightfox"), enabled = false },
  { "folke/tokyonight.nvim", config = get_setup("tokyonight"), enabled = false },
  { "catppuccin/nvim", name = "catppuccin", config = get_setup("catppuccin"), enabled = false },
}
