local wibox = require("wibox")
local beautiful = require("beautiful")
-- local awful = require("awful")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")

return function()
  local pfp = wibox.widget({
    {
      widget = wibox.widget.imagebox,
      image = beautiful.avatar,
      clip_shape = helpers.rrect(10),
      resize = true,
      valign = "center",
      halign = "center",
      spacing = beautiful.spacing,
    },
    forced_width = dpi(50),
    widget = wibox.container.margin,
    -- buttons = {
    --   awful.button({}, 1, function()
    --     awesome.emit_signal("controlcenter::toggle", mouse.screen)
    --   end),
    -- },
  })

  helpers.hoverCursor(pfp)

  return pfp
end
