--- @param background string
local function reload(background)
  if vim.o.background ~= background then
    vim.o.background = background;
    local plugin = require("lazy.core.config").plugins["min-theme.nvim"]
    require("lazy.core.loader").reload(plugin)
  end

  require("min-theme").colorscheme()
end

return {
  {
    "datsfilipe/min-theme.nvim",
    config = function()
      --- @type table<string, string>
      local guicursor = {}
      --- @type table<string, {bg: string?, fg: string?}>
      local highlight = {};

      vim.api.nvim_create_autocmd("ColorSchemePre", {
        desc = "min theme reloader",
        pattern = 'min-theme*',
        callback = function(ev)
          if ev.match == "min-theme" or ev.match == "min-theme-dark" then
            reload("dark")
          elseif ev.match == "min-theme-light" then
            reload("light")
          end
        end
      })

      vim.api.nvim_create_autocmd("ColorScheme", {
        desc = "handle cursor style",
        callback = function(ev)
          if ev.match == "min-theme-light" then
            vim.api.nvim_set_hl(0, "Cursor", { fg = "#ffffff", bg = "#000000", default = false })
            vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor"
          elseif highlight[ev.match] ~= nil and guicursor[ev.match] ~= nil then
            vim.api.nvim_set_hl(0, "Cursor", highlight[ev.match])
            vim.opt.guicursor = guicursor[ev.match];
          else
            local hl = vim.api.nvim_get_hl(0, { name = "Cursor" })
            local bg = hl.bg ~= nil and string.format('#%06x', hl.bg) or nil
            local fg = hl.fg ~= nil and string.format('#%06x', hl.fg) or nil
            highlight[ev.match] = { bg = bg, fg = fg }
            guicursor[ev.match] = vim.opt.guicursor;
          end
        end,
      })
    end,
  },
}
