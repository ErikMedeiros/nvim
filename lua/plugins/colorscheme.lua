return {
    "kaicataldo/material.vim",
    branch = "main",
    priority = 1000,
    config = function()
        vim.api.nvim_set_var("material_theme_style", "darker")
        vim.cmd.colorscheme("material")
    end,
}
