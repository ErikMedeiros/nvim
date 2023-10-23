vim.cmd([[
    augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost * FormatWrite
    augroup END
]])

return {
    "mhartington/formatter.nvim",
    config = function()
        local formatter = require("formatter.filetypes")

        require("formatter").setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                javascript = { formatter.javascript.prettier },
                javascriptreact = { formatter.javascriptreact.prettier },
                typescript = { formatter.typescript.prettier },
                typescriptreact = { formatter.typescriptreact.prettier },
                lua = { formatter.lua.stylua },
                css = { formatter.css.prettier },
                html = { formatter.html.prettier },
                yaml = { formatter.yaml.prettier },
                markdown = { formatter.markdown.prettier },
                json = { formatter.json.prettier },
                jsonc = { formatter.json.prettier },
                cs = { formatter.cs.dotnetformat },
                ["*"] = { formatter.any.remove_trailing_whitespace },
            },
        })
    end,
}
