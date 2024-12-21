return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require('mini.move').setup({})
      require("mini.statusline").setup({})

      vim.notify = require("mini.notify").make_notify()
      require("mini.notify").setup({
        window = {
          winblend = 100,
          config = function()
            local has_statusline = vim.o.laststatus > 0
            local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
            return { border = "rounded", anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad }
          end
        }
      })
    end,
  },
}
