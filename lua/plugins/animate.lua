local animate = require("mini.animate")
local timing = animate.gen_timing.linear({ duration = 50, unit = "total" })

return {
  "nvim-mini/mini.animate",
  enabled = false,
  event = "VeryLazy",
  opts = function()
    -- don't use animate when scrolling with the mouse
    local mouse_scrolled = false

    for _, scroll in ipairs({ "Up", "Down" }) do
      local key = "<ScrollWheel" .. scroll .. ">"
      vim.keymap.set({ "", "i" }, key, function()
        mouse_scrolled = true
        return key
      end, { expr = true })
    end

    return {
      resize = {
        enable = true,
        timing = timing,
      },
      cursor = {
        enable = true,
        timing = timing,
      },
      scroll = {
        enable = true,
        timing = timing,
        subscroll = animate.gen_subscroll.equal({
          timing = timing,
          predicate = function(total_scroll)
            if mouse_scrolled then
              mouse_scrolled = false
              return false
            end

            return total_scroll > 1
          end,
        }),
      },
    }
  end,
}
