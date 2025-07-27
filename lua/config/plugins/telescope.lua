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

      vim.keymap.set("n", "<space>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<space>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<space>sg", require("telescope.builtin").live_grep, { desc = "[S]earch [G]rep" })
      vim.keymap.set("n", "<space>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<space>cs", require("telescope.builtin").colorscheme, { desc = "[C]hange [C]olorScheme" })
      vim.keymap.set("n", "<space><space>", require("telescope.builtin").buffers, { desc = "Open Files" })

      vim.keymap.set("n", "<space>/", require("telescope.builtin").current_buffer_fuzzy_find,
        { desc = "Current Buffer Fuzzy" })

      vim.keymap.set("n", "<space>nv",
        function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end,
        { desc = "Search [N]eo[v]im Config Files" })
    end
  }
}
