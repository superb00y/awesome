local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local helpers = require("helpers")
local user = require("user")
local dpi = beautiful.xresources.apply_dpi

return function()
	local profile_image = wibox.widget({
		{
			image = user.avatar,
			clip_shape = gears.shape.circle,
			resize = true,
			valign = "center",
			halign = "center",
			widget = wibox.widget.imagebox,
		},
		widget = wibox.container.background,
		forced_width = dpi(60),
		forced_height = dpi(60),
		shape = gears.shape.circle,
		border_width = dpi(2),
		border_color = beautiful.fg_normal,
	})

	helpers.hoverCursor(profile_image)

	local username = wibox.widget({
		widget = wibox.widget.textbox,
		markup = helpers.colorizeText(user.username:gsub("^%l", string.upper), beautiful.accent),
		font = beautiful.font .. "Bold",
		align = "left",
		valign = "center",
	})

	helpers.hoverCursor(username)

	local desc = wibox.widget({
		widget = wibox.widget.textbox,
		markup = helpers.colorizeText("user@machine", beautiful.fg_normal),
		font = beautiful.font_mono .. "11",
		align = "left",
		valign = "center",
	})

	awful.spawn.easy_async_with_shell("uname -n", function(stdout)
		local hostname = stdout:match("(%w+)")
		desc.markup = helpers.colorizeText(" " .. user.username .. "@" .. hostname, beautiful.fg_normal)
	end)

	local uptime = wibox.widget({
		widget = wibox.widget.textbox,
		markup = helpers.colorizeText("Uptime unknown...", beautiful.fg_normal),
		font = beautiful.font_mono .. "11",
		align = "left",
		valign = "center",
	})

	awesome.connect_signal("signal::uptime", function(stdout)
		uptime.markup = helpers.colorizeText(stdout, beautiful.fg_normal)
	end)

	-- User Info Layout
	local user_info_layout = wibox.widget({
		profile_image,
		{
			nil,
			{
				username,
				desc,
				uptime,
				layout = wibox.layout.fixed.vertical,
				spacing = dpi(5),
			},
			layout = wibox.layout.fixed.vertical,
			expand = "none",
		},
		spacing = dpi(10),
		layout = wibox.layout.fixed.horizontal,
	})

	return wibox.widget({
		{
			user_info_layout,
			widget = wibox.container.margin,
			margins = dpi(10),
		},
		bg = beautiful.bg_light,
		shape = user.style == "rounded" and helpers.rrect(15) or user.style == "semi-rounded" and helpers.rrect(10),
		widget = wibox.container.background,
	})
end
