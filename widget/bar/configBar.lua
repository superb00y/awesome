local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")
local wibox = require("wibox")
local components = require("widget.bar.components")

return function(s, widgets)
  s.pfp = components.pfp(s)

  local config = awful.popup({
    widget = wibox.container.background,
    ontop = true,
    bg = beautiful.red,
    visible = true,
    screen = s,
    maximum_height = s.geometry.height * 0.8,
    placement = function(c)
      awful.placement.top_right(c, { margins = { right = dpi(10), top = dpi(10) } })
    end,
  })

  -- config:struts({
  --   top = 55,
  -- })

  local function prepare_widgets(widgets)
    local layout = {
      forced_width = dpi(35),
      layout = wibox.layout.fixed.vertical,
    }
    for i, widget in pairs(widgets) do
      if i == 1 then
        table.insert(layout, {
          widget,
          left = dpi(6),
          right = dpi(7),
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

  local parm = wibox.widget({
    {
      s.pfp,
      left = dpi(3),
      right = dpi(2),
      top = dpi(6),
      bottom = dpi(6),
      forced_height = dpi(45),
      forced_width = dpi(45),
      widget = wibox.container.margin,
    },
    shape = helpers.rrect(5),
    bg = beautiful.bg_normal,
    widget = wibox.container.background,
  })

  config:setup({
    {
      {
        parm,
        {
          {
            prepare_widgets(widgets),
            bg = beautiful.bg_light,
            shape = helpers.rrect(5),
            widget = wibox.container.background,
          },
          bottom = dpi(6),
          widget = wibox.container.margin,
        },
        spacing = 3,
        layout = wibox.layout.fixed.vertical,
      },
      margins = dpi(6),
      widget = wibox.container.margin,
    },
    nil,
    nil,
    layout = wibox.layout.align.vertical,
  })
end
