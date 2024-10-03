local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local wibox = require("wibox")

return function(s, lwidgets, mwidgets, rwidgets)
  local bar = awful.wibar({
    screen = s,
    position = "top",
    border_width = dpi(0),
    border_color = beautiful.transparent,
    bg = beautiful.transparent_bar and beautiful.transparent or beautiful.mid_dark,
    visible = true,
  })

  bar.height = s.geometry.height * 0.049
  bar.width = s.geometry.width * 0.021

  bar:struts({
    top = bar.height,
  })

  local function prepare_widgets(widgets)
    local layout = {
      forced_height = dpi(35),
      layout = wibox.layout.fixed.horizontal,
    }
    for i, widget in pairs(widgets) do
      if i == 1 then
        table.insert(layout, {
          widget,
          left = dpi(6),
          right = dpi(6),
          top = dpi(6),
          bottom = dpi(6),
          widget = wibox.container.margin,
        })
      elseif i == #widgets then
        table.insert(layout, {
          widget,
          left = dpi(3),
          right = dpi(6),
          top = dpi(6),
          bottom = dpi(6),
          widget = wibox.container.margin,
        })
      else
        table.insert(layout, {
          widget,
          left = dpi(3),
          right = dpi(3),
          top = dpi(6),
          bottom = dpi(6),
          widget = wibox.container.margin,
        })
      end
    end
    return layout
  end

  bar:setup({
    {
      prepare_widgets(lwidgets),
      spacing = dpi(beautiful.spacing),
      layout = wibox.layout.fixed.horizontal,
    },
    prepare_widgets(mwidgets),
    expand = "none",
    {
      prepare_widgets(rwidgets),
      spacing = dpi(beautiful.spacing),
      layout = wibox.layout.fixed.horizontal,
    },
    margins = dpi(4),
    widget = wibox.container.margin,
    layout = wibox.layout.align.horizontal,
  })
end
