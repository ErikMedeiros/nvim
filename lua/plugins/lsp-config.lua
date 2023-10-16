local servers = {
    rust_analyzer = {},
    tsserver = {},
    html = { filetypes = { "html", "twig", "hbs" } },
    eslint = {},
    csharp_ls = {},
    taplo = {},
    zls = {},
    tailwindcss = {},
    lua_ls = {
        Lua = {
            completion = { callSnippet = "Replace" },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    end,
})

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",

        -- Loading status on bottom right
        { "j-hui/fidget.nvim", tag = "legacy", config = true },

        -- Neovim config intellisense
        { "folke/neodev.nvim", config = true },
    },
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        -- Ensure the servers above are installed
        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(servers) })

        local lspconfig = require("lspconfig")

        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                })
            end,
        })
    end,
}
