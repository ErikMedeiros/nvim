return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "^.git/" },
          winblend = 10,
          path_display = {
            filename_first = { reverse_directories = true },
            "truncate"
          },
        },
        pickers = {
          help_tags = { theme = "ivy" },
          find_files = { hidden = true },
          colorscheme = { enable_preview = true },
          current_buffer_fuzzy_find = { previewer = false },
          buffers = {
            previewer = false,
            layout_strategy = "center",
            layout_config = { anchor = "CENTER" }
          },
        },
        extensions = {
          fzf = {},
          file_browser = { theme = "ivy", hijack_netrw = true },
          ["ui-select"] = { require("telescope.themes").get_dropdown() },
        }
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("ui-select")

      vim.keymap.set("n", "<space>sh", require("telescope.builtin").help_tags)
      vim.keymap.set("n", "<space>sf", require("telescope.builtin").find_files)
      vim.keymap.set("n", "<space>sg", require("telescope.builtin").live_grep)
      vim.keymap.set("n", "<space>sd", require("telescope.builtin").diagnostics)
      vim.keymap.set("n", "<space>cs", require("telescope.builtin").colorscheme)
      vim.keymap.set("n", "<space>/", require("telescope.builtin").current_buffer_fuzzy_find)
      vim.keymap.set("n", "<space><space>", require("telescope.builtin").buffers)

      vim.keymap.set("n", "<space>nv", function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end)
    end
  }
}
