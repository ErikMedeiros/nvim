return {
  { "sindrets/diffview.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          map('n', '<space>hs', gitsigns.stage_hunk)
          map('n', '<space>hr', gitsigns.reset_hunk)
          map('v', '<space>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('v', '<space>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('n', '<space>hS', gitsigns.stage_buffer)
          map('n', '<space>hR', gitsigns.reset_buffer)
          map('n', '<space>hu', gitsigns.undo_stage_hunk)
          map('n', '<space>hp', gitsigns.preview_hunk)
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
    end,
  }
}
