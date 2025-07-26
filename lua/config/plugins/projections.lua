return {
  'gnikdroy/projections.nvim',
  branch = "pre_release",
  enabled = true,
  config = function()
    require("projections").setup({
      workspaces = {
        { "~/repos",     {} },
        { "~/repos/gbm", {} }
      }
    })

    vim.opt.sessionoptions:append("localoptions")

    require('telescope').load_extension('projections')
    vim.keymap.set("n", "<leader>fp", ":Telescope projections<CR>", { silent = true, desc = "[F]ind [P]roject" })

    local Session = require("projections.session")
    vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
      callback = function() Session.store(vim.uv.cwd()) end,
    })

    local switcher = require("projections.switcher")
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      callback = function()
        if vim.fn.argc() == 0 then switcher.switch(vim.loop.cwd()) end
      end,
    })
  end
}
