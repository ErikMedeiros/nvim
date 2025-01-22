return {
  { "tpope/vim-sleuth" },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = { indent = { char = "┊" } },
  },
  {
    'stevearc/dressing.nvim',
    opts = { select = { enable = false } },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { preset = "modern", delay = 500 },
  },
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = "<space>t",
      insert_mappings = false,
      terminal_mappings = false,
      direction = "float",
      float_opts = { winblend = 10, border = "rounded" },
    },
  },
};
