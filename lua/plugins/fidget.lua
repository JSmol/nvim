return {
  'j-hui/fidget.nvim',
  opts = {
    progress = {},
    notification = {
      view = {
        stack_upwards = false,
        icon_separator = " ",
        group_separator = "---",
        group_separator_hl = "Comment",
        render_message = -- How to render notification messages
            function(msg, cnt)
              return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
            end,
      },
      window = {
        normal_hl = "Comment", -- Base highlight group in the notification window
        winblend = 100,        -- Background color opacity in the notification window
        border = "rounded",    -- Border around the notification window
        zindex = 45,           -- Stacking priority of the notification window
        max_width = 0,         -- Maximum width of the notification window
        max_height = 0,        -- Maximum height of the notification window
        x_padding = 1,         -- Padding from right edge of window boundary
        y_padding = 0,         -- Padding from bottom edge of window boundary
        align = "bottom",      -- How to align the notification window
        relative = "editor",   -- What the notification window position is relative to
      }
    }
  }
}
