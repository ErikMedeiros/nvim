return {
  { "tpope/vim-sleuth" },
  {
    "folke/snacks.nvim",
    priority = 1000,
    opts = {
      input = { enable = true },
      indent = { enable = true },
      statuscolumn = { enable = true },
      notifier = { enable = true, top_down = false },
    }
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require('mini.move').setup()
      require("mini.statusline").setup()
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      }
    }
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
      float_opts = { border = "rounded" },
    },
  },
};
