return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c",
                "cpp",
                "c_sharp",
                "rust",
                "javascript",
                "typescript",
                "lua",
                "vim",
                "vimdoc",
                "tsx",
                "zig",
                "html",
                "css",
                "toml",
                "yaml",
                "json",
                "jsdoc",
            },
            highlight = { enable = true },
            indent = true,
            sync_install = false,
            auto_install = true,
        })
    end,
}
