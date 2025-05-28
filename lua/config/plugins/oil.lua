return {
  'stevearc/oil.nvim',
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      columns = { "icon", "size" },
      view_options = { show_hidden = true },
    })

    --- @type vim.keymap.set.Opts
    local opts = { desc = "[B]rowse [c]urrent directory", silent = true }
    vim.keymap.set('n', '<leader>bc', ':Oil<CR>', opts);
  end,
}
