vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require("config.lazy")

vim.cmd.colorscheme("min-theme")

vim.opt.completeopt = "menuone,noinsert,preview,popup"
vim.keymap.set('i', '<CR>', [[pumvisible() ? "<C-y>" : "<CR>"]], { expr = true, silent = true })

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.foldlevelstart = 99
vim.opt.cursorline = true

vim.keymap.set({ "n", "v" }, "<space>", "<nop>")
vim.keymap.set({ "n", "v" }, "<C-c>", "\"+y")
vim.keymap.set("i", '<C-c>', '<Esc>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  desc = "highlight yanked text",
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- gpt neles porra
vim.keymap.set("n", "z<C-c>", function()
  local cur_line = vim.fn.line('.')
  local cur_level = vim.fn.foldlevel(cur_line)

  if cur_level < 0 then return end

  local fold_start = vim.fn.foldclosed(cur_line)
  if fold_start == -1 then
    local l = cur_line
    while l > 1 and vim.fn.foldlevel(l - 1) >= cur_level do
      l = l - 1
    end
    fold_start = l
  end

  local fold_end = vim.fn.foldclosedend(cur_line)
  if fold_end == -1 then
    local l = cur_line
    local max = vim.fn.line('$')
    while l < max and vim.fn.foldlevel(l + 1) >= cur_level do
      l = l + 1
    end
    fold_end = l
  end

  local lnum = fold_start + 1
  while lnum <= fold_end do
    local level = vim.fn.foldlevel(lnum)
    local closed = vim.fn.foldclosed(lnum)

    if level == cur_level + 1 and closed == -1 then
      vim.cmd(lnum .. 'foldclose')
    end

    local skip = vim.fn.foldclosedend(lnum)
    if skip ~= -1 then
      lnum = skip + 1
    else
      lnum = lnum + 1
    end
  end
end, { desc = "Fold all direct childen" })
