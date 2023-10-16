return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = false,
                theme = require("material.lualine"),
                component_separators = "|",
                section_separators = "",
            },
        })
    end,
}
