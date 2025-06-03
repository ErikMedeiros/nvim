--- @param client vim.lsp.Client
--- @param bufnr integer
local on_attach = function(client, bufnr)
  --- vim.keymap.set bound to bufnr
  --- @param mode string|string[]
  --- @param lhs string
  --- @param rhs string|function
  --- @param opts vim.keymap.set.Opts?
  local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  if client:supports_method('textDocument/definition') then
    map("n", "grd", require("telescope.builtin").lsp_definitions, { desc = "vim.lsp.buf.definition" })
  end

  if client:supports_method('textDocument/typeDefinition*') then
    map("n", "grt", require("telescope.builtin").lsp_type_definitions, { desc = "vim.lsp.buf.type_definition" })
  end

  if client:supports_method('textDocument/foldingRange') then
    local win = vim.api.nvim_get_current_win()
    vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
  end

  if client.name ~= 'ts_ls' and client:supports_method('textDocument/formatting') then
    --- @param opts vim.lsp.buf.format.Opts
    local format = function(opts)
      opts = opts or {}
      opts.bufnr = bufnr
      opts.id = client.id
      vim.lsp.buf.format(opts)
    end

    map("n", "<space>f", format, { desc = "LSP: [F]ormat" })

    if not client:supports_method('textDocument/willSaveWaitUntil') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = bufnr,
        callback = function() format({ timeout_ms = 1000 }) end,
      })
    end
  end

  map("n", "grr", require("telescope.builtin").lsp_references, { desc = "vim.lsp.buf.references" })
  map("n", "gri", require("telescope.builtin").lsp_implementations, { desc = "vim.lsp.buf.implementation" })
  map("n", "gO", require("telescope.builtin").lsp_document_symbols, { desc = "vim.lsp.buf.document_symbol" })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "Decodetalkers/csharpls-extended-lsp.nvim" },
    config = function()
      vim.diagnostic.config({ virtual_text = true });

      vim.lsp.enable("biome")
      vim.lsp.enable("csharp_ls")
      vim.lsp.enable("eslint")
      vim.lsp.enable("gopls")
      vim.lsp.enable("hls")
      vim.lsp.enable("jsonls")
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("tailwindcss")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("zls")

      require("csharpls_extended").buf_read_cmd_bind()
      require("telescope").load_extension("csharpls_definition")

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          on_attach(client, args.buf)
        end,
      })

      vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(ev)
          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
            id = "lsp_progress",
            title = "LSP Progress",
            opts = function(notif)
              notif.icon = ev.data.params.value.kind == "end" and " "
                  or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      })

      vim.lsp.handlers['client/registerCapability'] = (function(overridden)
        return function(err, res, ctx)
          local result = overridden(err, res, ctx)
          local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
          on_attach(client, vim.api.nvim_get_current_buf())
          return result
        end
      end)(vim.lsp.handlers['client/registerCapability'])
    end,
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      appearance = { nerd_font_variant = 'mono' },
      completion = { documentation = { auto_show = true, } },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' }, },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" }
  }
}
