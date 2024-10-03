local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local createButton = function(c, fn)
  local btn = wibox.widget({
    forced_width = dpi(15),
    forced_height = dpi(15),
    bg = beautiful.accent,
    shape = helpers.rrect(5),
    buttons = {
      awful.button({}, 1, function()
        fn(c)
      end),
    },
    widget = wibox.container.background,
  })

  return btn
end

client.connect_signal("request::titlebars", function(c)
  local close = createButton(c, function(c1)
    c1:kill()
  end)

  local maximize = createButton(c, function(c1)
    c1.maximized = not c1.maximized
  end)

  local minimize = createButton(c, function(c1)
    gears.timer.delayed_call(function()
      c1.minimized = not c1.minimized
    end)
  end)

  local buttons = gears.table.join(

    awful.button({}, 1, function()
      client.focus = c
      c:raise()
      awful.mouse.client.move(c)
    end),

    awful.button({}, 3, function()
      client.focus = c
      c:raise()
      awful.mouse.client.resize(c)
    end)
  )

  awful
    .titlebar(c, {
      size = dpi(26),
      position = "top",
    })
    :setup({
      {
        {
          {
            {
              {
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c),
                font = beautiful.font .. "Bold 12",
              },
              spacing = dpi(beautiful.spacing),
              widget = wibox.container.margin,
              visible = true,
              align = "center",
            },
            right = dpi(20),
            left = dpi(20),
            widget = wibox.container.margin,
          },
          shape = helpers.Trrect(5),
          bg = beautiful.bg_dark,
          fg = beautiful.fg_normal,
          widget = wibox.container.background,
        },
        nil,
        {
          {
            {
              {
                minimize,
                maximize,
                close,
                spacing = dpi(beautiful.spacing),
                widget = wibox.container.place,
                halign = "center",
                visible = true,
                layout = wibox.layout.fixed.horizontal,
              },
              left = dpi(20),
              right = dpi(20),
              top = dpi(4),
              bottom = dpi(4),
              widget = wibox.container.margin,
            },
            widget = wibox.container.place,
            halign = "center",
          },
          shape = helpers.Trrect(5),
          bg = beautiful.bg_dark,
          widget = wibox.container.background,
        },
        layout = wibox.layout.align.horizontal,
      },
      bottom = dpi(-2),
      widget = wibox.container.margin,
    })
end)
