return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function(_, opts)
        require("toggleterm").setup(opts)
        vim.keymap.set("n", "<leader>t", '<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>', { desc = "[T]oggle terminal" })
        vim.keymap.set("n", "<leader>ft", '<Cmd>execute v:count . "ToggleTerm direction=float"<CR>', { desc = "Toggle [F]loat [T]erminal" })
    end,
}
