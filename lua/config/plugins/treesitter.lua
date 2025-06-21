local ensure_installed = {
  "bash",
  "c", "c_sharp", "cpp", "css",
  "git_config", "git_rebase", "gitcommit", "go",
  "haskell", "html",
  "javascript", "jsdoc", "json", "jsonc",
  "lua",
  "markdown",
  "tsx", "typescript",
  "xml",
  "zig"
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = function()
      vim.cmd(":TSUpdate")
      require("nvim-treesitter").install(ensure_installed)
    end,
    config = function()
      require("nvim-treesitter").setup()

      local set = {}
      for _, lang in ipairs(ensure_installed) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
          set[ft] = true;
        end
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = vim.tbl_keys(set),
        callback = function()
          vim.treesitter.start()
          vim.wo.foldmethod = 'expr'
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
