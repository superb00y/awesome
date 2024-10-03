local awful = require("awful")
local wibox = require("wibox")
local ruled = require("ruled")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local helpers = require("helpers")

local user = require("user")
local dpi = beautiful.xresources.apply_dpi

-- naughty config
naughty.config.defaults.ontop = true
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.title = "Ding!"
naughty.config.defaults.border_width = 0

ruled.notification.connect_signal("request::rules", function()
  ruled.notification.append_rule({
    rule = { urgency = "critical" },
    properties = {
      bg = beautiful.bg_dark,
      fg = beautiful.red,
      position = user.notification_pos,
      spacing = dpi(user.outer_gaps),
      timeout = 0,
    },
  })
  ruled.notification.append_rule({
    rule = { urgency = "normal" },
    properties = {
      bg = beautiful.bg_dark,
      fg = beautiful.fg_normal,
      position = user.notification_pos,
      spacing = dpi(user.outer_gaps),
      timeout = 0,
    },
  })
  ruled.notification.append_rule({
    rule = { urgency = "low" },
    properties = {
      bg = beautiful.bg_dark,
      fg = beautiful.fg_normal,
      position = user.notification_pos,
      spacing = dpi(user.outer_gaps),
      timeout = 0,
    },
  })
end)

----------------------------
--Template------------------
----------------------------
local actions_template = wibox.widget({
  notification = n,
  base_layout = wibox.widget({
    spacing = dpi(0),
    layout = wibox.layout.flex.horizontal,
  }),
  widget_template = {
    {
      {
        {
          {
            id = "text_role",
            font = beautiful.font .. "12",
            widget = wibox.widget.textbox,
          },
          widget = wibox.container.place,
        },
        widget = wibox.container.background,
        bg = beautiful.bg_normal,
      },
      bg = beautiful.bg_normal,
      shape = gears.shape.rounded_rect,
      forced_height = dpi(30),
      widget = wibox.container.background,
    },
    margins = dpi(6),
    widget = wibox.container.margin,
  },
  style = { underline_normal = false, underline_selected = true },
  widget = naughty.list.actions,
})

--Template------------------
naughty.connect_signal("request::display", function(n)
  naughty.layout.box({
    notification = n,
    type = "notification",
    bg = beautiful.bg_normal,
    widget_template = {
      {
        {
          {
            {
              {
                {
                  naughty.widget.title,
                  font = beautiful.font .. "14",
                  forced_height = dpi(20),
                  layout = wibox.layout.align.horizontal,
                },
                left = dpi(15),
                right = dpi(15),
                top = dpi(10),
                bottom = dpi(10),
                widget = wibox.container.margin,
              },
              bg = beautiful.bg_normal,
              widget = wibox.container.background,
            },
            strategy = "min",
            width = dpi(300),
            widget = wibox.container.constraint,
          },
          strategy = "max",
          width = dpi(400),
          widget = wibox.container.constraint,
        },
        {
          {
            {
              {
                resize_strategy = "center",
                widget = wibox.widget.imagebox,
                image = n.icon or beautiful.awesome_icon,
                clip_shape = user.style == "rounded" and gears.shape.circle
                  or user.style == "semi-rounded" and helpers.rrect(10)
                  or gears.shape.rectangle,
              },
              margins = dpi(10),
              widget = wibox.container.margin,
              forced_height = dpi(30),
              forced_width = dpi(90),
            },
            widget = wibox.container.background,
            bg = beautiful.bg_dark .. "00",
          },
          {
            {
              {
                naughty.widget.message,
                left = dpi(15),
                right = dpi(15),
                top = dpi(10),
                bottom = dpi(10),
                widget = wibox.container.margin,
              },
              strategy = "min",
              height = dpi(60),
              widget = wibox.container.constraint,
            },
            strategy = "max",
            width = dpi(400),
            widget = wibox.container.constraint,
          },
          layout = wibox.layout.align.horizontal,
        },
        {
          actions_template,
          widget = wibox.container.margin,
          top = 0,
          bottom = 5,
          left = 10,
          right = 10,
        },
        layout = wibox.layout.align.vertical,
      },
      id = "background_role",
      widget = naughty.container.background,
      bg = beautiful.bg_light,
    },
  })
end)
