return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      columns = { "icon", "size" },
      view_options = { show_hidden = true },
    })

    vim.keymap.set('n', '<leader>bc', ':Oil<CR>', { desc = "[B]rowse [c]urrent directory" });
  end,
}
