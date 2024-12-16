return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "Decodetalkers/csharpls-extended-lsp.nvim" },
    config = function()
      require("lspconfig").csharp_ls.setup({})

      require("lspconfig").eslint.setup({
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", { buffer = bufnr, command = "EslintFixAll", })
          vim.keymap.set({ "n", "v" }, "<space>f", ":EslintFixAll<CR>", { silent = true, buffer = bufnr })
        end
      })

      require("lspconfig").hls.setup({ filetypes = { "haskell", "lhaskell", "cabal" } })
      require("lspconfig").lua_ls.setup({})
      require("lspconfig").nixd.setup({})
      require("lspconfig").tailwindcss.setup({})
      require("lspconfig").ts_ls.setup({})
      require("lspconfig").zls.setup({})

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttached", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.name == "ts_ls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end

          vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = args.buf })
          vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = args.buf })
          vim.keymap.set({ "n", "v" }, "gca", vim.lsp.buf.code_action, { buffer = args.buf })
          vim.keymap.set("n", "grr", require("telescope.builtin").lsp_references, { buffer = args.buf })
          vim.keymap.set("n", "gri", require("telescope.builtin").lsp_implementations, { buffer = args.buf })
          vim.keymap.set("n", "gO", require("telescope.builtin").lsp_document_symbols, { buffer = args.buf })

          if vim.bo[args.buf].filetype == "cs" then
            vim.keymap.set("n", "grd", ":Telescope csharpls_definition<CR>", { silent = true, buffer = args.buf })
            vim.keymap.set("n", "grt", ":Telescope csharpls_definition<CR>", { silent = true, buffer = args.buf })
          else
            vim.keymap.set("n", "grd", require("telescope.builtin").lsp_definitions, { buffer = args.buf })
            vim.keymap.set("n", "grt", require("telescope.builtin").lsp_type_definitions, { buffer = args.buf })
          end

          if client.supports_method("textDocument/formatting", { bufnr = args.buf }) then
            local function format()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end

            vim.keymap.set({ "n", "v" }, "<space>f", format, { buffer = args.buf })
            vim.api.nvim_create_autocmd("BufWritePre", { buffer = args.buf, callback = format })
          end
        end,
      })
    end,
  },
}
