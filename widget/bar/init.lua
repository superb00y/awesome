local awful = require("awful")
local beautiful = require("beautiful")
local components = require("widget.bar.components")

screen.connect_signal("request::desktop_decoration", function(s)
  awful.tag(beautiful.tags, s, awful.layout.layouts[1])

  s.layout = components.layouts(s)
  s.pfp = components.pfp(s)
  s.home = components.home()
  s.taglist = components.tags(s)
  s.clock = components.clock()
  s.sys = components.systray()
  s.scr = components.screenshot()
  s.task = components.tasks(s)

  if s.index == 1 then
    require("widget.bar.bar")(s, { s.home, s.taglist }, { s.task }, { s.sys, s.layout, s.clock, s.pfp })
    require("widget.bar.promptbar")
  elseif s.index == 2 then
    require("widget.bar.bar")(s, { s.home, s.taglist }, { s.task }, { s.scr, s.layout, s.pfp })
    require("widget.bar.promptbar")
  end
end)
