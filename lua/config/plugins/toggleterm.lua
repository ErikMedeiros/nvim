return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = "<space>t",
        insert_mappings = false,
        terminal_mappings = false,
        direction = "float",
        float_opts = {
          winblend = 10,
          border = "rounded",
        },
      })
    end,
  }
}
