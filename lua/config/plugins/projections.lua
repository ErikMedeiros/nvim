return {
  'gnikdroy/projections.nvim',
  branch = "pre_release",
  config = function()
    require("projections").setup({
      workspaces = {
        { "~/repos",     {} },
        { "~/repos/gbm", {} },
      }
    })

    require('telescope').load_extension('projections')
    vim.keymap.set("n", "<leader>sp", ":Telescope projections<CR>", { silent = true, desc = "[S]earch [P]rojects" })

    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function() require("projections.session").store(vim.fn.getcwd()) end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      nested = true,
      callback = function()
        if vim.fn.argc() == 0 then require("projections.switcher").switch(vim.fn.getcwd()) end
      end,
    })
  end
}
