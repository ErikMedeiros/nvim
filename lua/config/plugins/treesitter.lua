return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local install_dir = vim.fn.stdpath("data") .. "/tree-sitter-parser"
      vim.opt.runtimepath:prepend(install_dir)

      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        parser_install_dir = install_dir,
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        auto_install = true,

        highlight = {
          enable = true,
          disable = function(_, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            return ok and stats and stats.size > max_filesize
          end,
        },

        indent = {
          enable = true
        }
      })

      -- vim.wo.foldmethod = 'expr'
      -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      -- vim.wo.foldcolumn = '0'
      -- vim.opt.foldenable = true
      -- vim.opt.foldlevelstart = 99
    end,
  },
}
