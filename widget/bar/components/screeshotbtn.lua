local wibox = require("wibox")
local naughty = require("naughty")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

return function()
  local function shotbtn_widget(image, button)
    local shot = wibox.widget({
      {
        {
          image = image,
          align = "center",
          widget = wibox.widget.imagebox,
        },
        valign = "center",
        halign = "center",
        widget = wibox.container.place,
      },
      forced_width = dpi(16),
      widget = wibox.container.place,
      buttons = {
        awful.button({}, 1, button),
      },
    })
    return shot
  end

  local shot_btn_full = shotbtn_widget(beautiful.shotfull, function()
    awful.spawn.easy_async_with_shell("/home/youq-chan/.config/awesome/scripts/screenshot full ")
    naughty.notify({
      app_name = "awesome",
      title = "Screenshot",
      message = "Saved to ",
      actions = {},
    })
  end)

  local shot_btn_area = shotbtn_widget(beautiful.shotarea, function()
    awful.spawn.easy_async_with_shell("/home/youq-chan/.config/awesome/scripts/screenshot area ")
  end)

  local shot_btn_areamagick = shotbtn_widget(beautiful.shotareamagick, function()
    awful.spawn.easy_async_with_shell("/home/youq-chan/.config/awesome/scripts/screenshot areamagick ")
  end)

  local shot_btn_active = shotbtn_widget(beautiful.shotactive, function()
    awful.spawn.easy_async_with_shell("/home/youq-chan/.config/awesome/scripts/screenshot active ")
  end)

  local shot_btn_activemagick = shotbtn_widget(beautiful.shotactivemagick, function()
    awful.spawn.easy_async_with_shell("/home/youq-chan/.config/awesome/scripts/screenshot activemagick ")
  end)

  helpers.hoverCursor(shot_btn_full)
  helpers.hoverCursor(shot_btn_area)
  helpers.hoverCursor(shot_btn_areamagick)
  helpers.hoverCursor(shot_btn_active)
  helpers.hoverCursor(shot_btn_activemagick)

  local buttons = wibox.widget({
    {
      {
        shot_btn_full,
        shot_btn_area,
        shot_btn_areamagick,
        shot_btn_active,
        shot_btn_activemagick,
        spacing = dpi(beautiful.spacing / 2),
        margins = dpi(10),
        layout = wibox.layout.fixed.horizontal,
      },
      left = dpi(9),
      right = dpi(9),
      top = dpi(0),
      bottom = dpi(0),
      widget = wibox.container.margin,
    },
    bg = beautiful.bg_normal,
    shape = helpers.rrect(10),
    visible = true,
    widget = wibox.container.background,
  })
  return buttons
end
