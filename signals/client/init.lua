local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

client.connect_signal("manage", function(c)
  if not awesome.startup then
    awful.client.setslave(c)
  end
  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end

  if beautiful.titlebar_enabled == false then
    c.shape = function(cr, width, height)
      if c.fullscreen or c.maximized then
        gears.shape.rectangle(cr, width, height)
      else
        gears.shape.rounded_rect(cr, width, height, 15)
      end
    end
  end
end)

client.connect_signal("property::fullscreen", function(c)
  c:raise()
end)
