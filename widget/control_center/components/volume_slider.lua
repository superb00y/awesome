local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

return function()
	local volume_slider = wibox.widget({
		widget = wibox.widget.slider,
		bar_height = dpi(35),
		bar_color = beautiful.mid_dark,
		bar_active_color = beautiful.blue,
		bar_shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, dpi(15))
		end,
		value = 69,

		handle_color = beautiful.blue,
		handle_width = dpi(35),
		handle_border_color = beautiful.bg_dim,
		handle_border_width = 0,
		handle_shape = function(c, w, h)
			gears.shape.rounded_rect(c, w, h, dpi(15))
		end,
		minimum = 0,
		maximum = 100,

		forced_height = dpi(35),
	})

	helpers.hoverCursor(volume_slider)

	local update_volume_slider = function()
		awful.spawn.easy_async("amixer sget Master", function(stdout)
			local volume = tonumber(string.match(stdout, "(%d?%d?%d)%%"))
			volume_slider.value = volume
		end)
	end

	local volume_slider_timer = gears.timer({
		timeout = 1,
		call_now = true,
		autostart = true,
		callback = update_volume_slider,
	})

	volume_slider:connect_signal("property::value", function(slider)
		local volume_level = math.floor(slider.value / 100 * 100)
		awful.spawn("amixer set Master " .. volume_level .. "%")
	end)

	local icon = wibox.widget({
		{
			image = beautiful.volumeicon, -- Replace with the path to your icon image
			resize = true,
			widget = wibox.widget.imagebox,
		},
		layout = wibox.container.margin,
		margins = { right = dpi(9) },
	})

	local vol_slider = wibox.widget({
		{
			icon,
			volume_slider,
			layout = wibox.layout.fixed.horizontal,
		},
		widget = wibox.container.margin,
		forced_height = dpi(35),
	})

	return vol_slider
end
