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
      vim.api.nvim_create_autocmd("ColorSchemePre", {
        desc = "min theme reloader",
        callback = function(ev)
          if ev.match == "min-theme" or ev.match == "min-theme-dark" then
            reload("dark")
          elseif ev.match == "min-theme-light" then
            reload("light")
          end
        end,
      })
    end,
  },
}
