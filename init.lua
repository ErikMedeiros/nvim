vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.lazy")

vim.cmd.colorscheme("min-theme-dark")

vim.opt.completeopt = "menuone,noinsert,preview,popup"
vim.keymap.set('i', '<CR>', [[pumvisible() ? "<C-y>" : "<CR>"]], { expr = true, silent = true })

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.undofile = true

vim.keymap.set({ "n", "v" }, "<space>", "<nop>")
vim.keymap.set({ "n", "v" }, "<C-c>", "\"+y")

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  desc = "highlight yanked text",
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
