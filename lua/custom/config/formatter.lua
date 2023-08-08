local filetypes = require "formatter.filetypes"

require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    lua = { filetypes.lua.stylua },
    html = { filetypes.html.prettier },
    css = { filetypes.css.prettier },
    javascript = { filetypes.javascript.prettier },
    javascriptreact = { filetypes.javascriptreact.prettier },
    json = { filetypes.json.prettier },
    rust = { filetypes.rust.rustfmt },
    typescript = { filetypes.typescript.prettier },
    typescriptreact = { filetypes.typescriptreact.prettier },
    toml = { filetypes.toml.taplo },
    ["*"] = { filetypes.any.remove_trailing_whitespace },
  },
}
