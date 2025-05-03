return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    set({ "n", "x" }, "<c-up>", function() mc.lineAddCursor(-1) end, { desc = "Add cursor above" })
    set({ "n", "x" }, "<c-down>", function() mc.lineAddCursor(1) end, { desc = "Add cursor below" })
    set({ "n", "x" }, "<space><up>", function() mc.lineSkipCursor(-1) end, { desc = "Skip cursor above" })
    set({ "n", "x" }, "<space><down>", function() mc.lineSkipCursor(1) end, { desc = "Skip cursor below" })

    set({ "n", "x" }, "<space>n", function() mc.matchAddCursor(1) end, { desc = "Add cursor to next match" })
    set({ "n", "x" }, "<space>s", function() mc.matchSkipCursor(1) end, { desc = "Skip cursor on the next match" })
    set({ "n", "x" }, "<space>N", function() mc.matchAddCursor(-1) end, { desc = "Add cursor to previous match" })
    set({ "n", "x" }, "<space>S", function() mc.matchSkipCursor(-1) end, { desc = "Skip cursor on the previous match" })

    set("n", "<space>/A", mc.searchAllAddCursors, { desc = "Add cursor to every search result" })
    set({ "n", "x" }, "<space>A", mc.matchAllAddCursors, { desc = "Add cursor to every match under the cursor" })
    set({ "n", "x" }, "g<c-a>", mc.sequenceIncrement, { desc = "Increment all cursors" })
    set({ "n", "x" }, "g<c-x>", mc.sequenceDecrement, { desc = "Decrement all cursors" })

    set("n", "<c-leftmouse>", mc.handleMouse)
    set("n", "<c-leftdrag>", mc.handleMouseDrag)
    set("n", "<c-leftrelease>", mc.handleMouseRelease)

    set({ "n", "x" }, "<c-q>", mc.toggleCursor, { desc = "Toggle current cursor" })

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      layerSet({ "n", "x" }, "<left>", mc.prevCursor, { desc = "Change main cursor to previous" })
      layerSet({ "n", "x" }, "<right>", mc.nextCursor, { desc = "Change main cursor to next" })
      layerSet({ "n", "x" }, "<space>x", mc.deleteCursor, { desc = "Delete cursor" })

      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end, { desc = "Clear cursors" })
    end)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { reverse = true })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end
}
