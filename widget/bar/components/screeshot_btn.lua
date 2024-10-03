local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")

return function()
  local screenshot_btn = wibox.widget({
    {
      {
        {
          text = "󰅂",
          font = beautiful.font .. "16",
          align = "center",
          widget = wibox.widget.textbox,
        },
        width = dpi(30),
        widget = wibox.container.margin,
      },
      direction = "south",
      widget = wibox.container.rotate,
    },
    bg = beautiful.bg_dark,
    shape = helpers.rrect(),
    visible = true,
    widget = wibox.container.background,
    buttons = {
      awful.button({}, 1, function()
        -- awesome.emit_signal("screenshot::toggle")
      end),
    },
  })
  helpers.hoverCursor(screenshot_btn)

  return screenshot_btn
end
