local awful = require("awful")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")
local pp = require("modules.prompt")
local wibox = require("wibox")

local launcher = {}

launcher.prompt = pp({
  textbox = wibox.widget.textbox(),
  prompt = "Run: ",
  font = beautiful.font .. "14",
  fg_cursor = beautiful.blue,
  bg_cursor = beautiful.accent,
  completion_callback = awful.completion.shell,
  keypressed_callback = function(mod, key, cmd)
    if key == "Escape" then
      launcher:hide()
    end
    if key == "Return" then
      awful.spawn.with_shell(cmd)
      launcher:hide()
    end
  end,
})

launcher.widget = awful.popup({
  ontop = true,
  bg = beautiful.transparent,
  visible = false,
  placement = function(c)
    awful.placement.top(c, { margins = dpi(100) })
  end,
  widget = {
    nil,
    {
      {
        {
          {
            {
              launcher.prompt.textbox,
              left = dpi(15),
              right = dpi(15),
              bottom = dpi(2),
              top = dpi(2),
              widget = wibox.container.margin,
            },
            shape = helpers.rrect(10),
            widget = wibox.container.background,
          },
          margins = dpi(6),
          forced_height = 60,
          forced_width = 590,
          widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      shape = helpers.rrect(5),
      bg = beautiful.bg_dark,
      border_width = 2,
      border_color = beautiful.accent .. 50,
      widget = wibox.container.background,
    },
    nil,
    layout = wibox.layout.fixed.horizontal,
  },
})

function launcher:show()
  local screen = awful.screen.focused()
  self.screen = screen
  screen.launcher = launcher.widget
  screen.launcher.screen = screen
  self.prompt:start()
  screen.launcher.visible = true
end

function launcher:hide()
  local screen = self.screen
  if screen.launcher == nil or screen.launcher.visible == false then
    return
  end
  self.prompt:stop()
  screen.launcher.visible = false
  screen.launcher = nil
end

function launcher:toggle()
  local screen = awful.screen.focused()
  if screen.launcher and screen.launcher.visible then
    self:hide()
  else
    self:show()
  end
end

awful.mouse.append_client_mousebinding(awful.button({}, 1, function(c)
  launcher:hide()
end))

awful.mouse.append_global_mousebinding(awful.button({}, 1, function(c)
  launcher:hide()
end))
awful.mouse.append_client_mousebinding(awful.button({}, 3, function(c)
  launcher:hide()
end))

awful.mouse.append_global_mousebinding(awful.button({}, 3, function(c)
  launcher:hide()
end))

return launcher
