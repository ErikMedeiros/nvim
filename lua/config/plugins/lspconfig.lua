return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "Decodetalkers/csharpls-extended-lsp.nvim" },
    config = function()
      local servers = {
        jsonls = {},
        biome = {
          root_dir = function(filename)
            return vim.fs.root(filename, { 'biome.json', 'biome.jsonc' });
          end
        },
        csharp_ls = {},
        eslint = {
          root_dir = function(filename)
            return vim.fs.root(filename,
              { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json",
                "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint-config.ts" })
          end,
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", { buffer = bufnr, command = "EslintFixAll", })
            vim.keymap.set({ "n", "v" }, "<space>f", ":EslintFixAll<CR>", { silent = true, buffer = bufnr })
          end
        },
        hls = { filetypes = { "haskell", "lhaskell", "cabal" } },
        lua_ls = {},
        nixd = {},
        tailwindcss = {
          root_dir = function(filename)
            return vim.fs.root(filename,
              { 'tailwind.config.js', 'tailwind.config.mjs', 'tailwind.config.cjs', 'tailwind.config.ts' });
          end
        },
        ts_ls = {},
        zls = {},
      }

      for server, config in pairs(servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        require("lspconfig")[server].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttached", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          local function map(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = args.buf
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          if client.name == "ts_ls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end

          map("n", "grn", vim.lsp.buf.rename)
          map("i", "<C-s>", vim.lsp.buf.signature_help)
          map({ "n", "v" }, "gca", vim.lsp.buf.code_action)
          map("n", "grr", require("telescope.builtin").lsp_references)
          map("n", "gri", require("telescope.builtin").lsp_implementations)
          map("n", "gO", require("telescope.builtin").lsp_document_symbols)

          if vim.bo[args.buf].filetype == "cs" then
            map("n", "grd", ":Telescope csharpls_definition<CR>", { silent = true })
            map("n", "grt", ":Telescope csharpls_definition<CR>", { silent = true })
          else
            map("n", "grd", require("telescope.builtin").lsp_definitions)
            map("n", "grt", require("telescope.builtin").lsp_type_definitions)
          end

          if client.supports_method("textDocument/formatting", { bufnr = args.buf }) then
            local function format()
              vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
            end

            map({ "n", "v" }, "<space>f", format)
            vim.api.nvim_create_autocmd("BufWritePre", { buffer = args.buf, callback = format })
          end
        end,
      })
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = '*',
    config = function()
      require("blink.cmp").setup({
        keymap = { preset = 'enter' },

        completion = {
          keyword = { range = 'full' },
          menu = { border = 'rounded' },
          list = {
            selection = {
              preselect = function(ctx) return ctx.mode ~= 'cmdline' end,
              auto_insert = true,
            }
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
            window = { border = 'rounded' },
          },
        },

        signature = {
          enabled = true,
          window = { border = 'rounded' },
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
