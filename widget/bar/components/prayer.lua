local wibox = require("wibox")
local pray = require("widget.bar.components.p")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local user = require("user")

return function()
  local prayer_widget = wibox.widget({
    {
      {
        id = "text",
        markup = helpers.colorizeText("prayer_time", beautiful.fg_normal),
        font = user.font .. "12",
        valign = "center",
        halign = "center",
        widget = wibox.widget.textbox,
      },
      left = dpi(15),
      right = dpi(15),
      bottom = dpi(2),
      top = dpi(2),
      widget = wibox.container.margin,
    },
    fg = beautiful.fg_normal,
    bg = beautiful.bg_normal,
    visible = true,
    shape = user.style == "rounded" and helpers.rrect(50)
      or user.style == "semi-rounded" and helpers.rrect(10)
      or gears.shape.rectangle,
    widget = wibox.container.background,
  })

  function Update_prayer_times()
    local latitude = 35.789485
    local longitude = -0.424080
    local offset = {
      fajr = 5, -- add 5 minutes to Fajr
      dhuhr = -10, -- subtract 10 minutes from Dhuhr
      asr = 0, -- no change for Asr
      maghrib = 0, -- no change for Maghrib
      isha = 0, -- no change for Isha
    }
    local methode = 19
    local prayers, err = pray.get_prayers_time(latitude, longitude, methode, offset)

    if err then
      prayer_widget.visible = false
    else
      local current_time = os.date("%H:%M")
      local next_prayer = nil
      local prayer_text = ""

      for prayer_name, prayer_time in pairs(prayers) do
        if current_time < prayer_time or (prayer_time == current_time and prayer_time >= current_time) then
          next_prayer = prayer_name
          break
        end
      end

      if next_prayer then
        local next_prayer_time = os.time({
          year = os.date("%Y"),
          month = os.date("%m"),
          day = os.date("%d"),
          hour = tonumber(string.sub(prayers[next_prayer], 1, 2)),
          min = tonumber(string.sub(prayers[next_prayer], 4, 5)),
        })

        local current_timee = os.time(os.date("*t"))
        local time_diff = os.difftime(next_prayer_time, current_timee)

        if time_diff <= 900 then -- 15 minutes
          prayer_widget.bg = beautiful.yellow
          prayer_text = string.upper(next_prayer) .. " : " .. prayers[next_prayer]
          prayer_widget:get_children_by_id("text")[1].markup = helpers.colorizeText(prayer_text, beautiful.bg_normal)
        else
          prayer_widget.bg = beautiful.bg_normal
          prayer_text = string.upper(next_prayer) .. " : " .. prayers[next_prayer]
          prayer_widget:get_children_by_id("text")[1].markup = helpers.colorizeText(prayer_text, beautiful.accent)
        end
      else
        prayer_widget.visible = false
      end
    end
  end

  Update_prayer_times()

  gears.timer({
    timeout = 60,
    autostart = true,
    call_now = false,
    callback = function()
      Update_prayer_times()
    end,
  })

  return prayer_widget
end
