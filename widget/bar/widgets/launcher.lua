--------------------------------
-- This is the power widget --
--------------------------------

-- Awesome Libs
local awful = require("awful")
local color = require("src.theme.colors")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local wibox = require("wibox")
require("src.core.signals")

-- Icon directory path
local icondir = awful.util.getdir("config") .. "src/assets/icons/"

local apps = require("src.widgets.apps")

return function()
	local launcher_widget = wibox.widget({
		{
			{
				{
					{
						id = "icon",
						image = gears.color.recolor_image(icondir .. "linux.svg", color["White"]),
						widget = wibox.widget.imagebox,
						resize = true,
					},
					id = "icon_layout",
					widget = wibox.container.place,
				},
				id = "icon_margin",
				top = dpi(3),
				bottom = dpi(3),
				widget = wibox.container.margin,
			},
			id = "launcher_layout",
			layout = wibox.layout.fixed.horizontal,
		},
		id = "container",
		left = dpi(6),
		right = dpi(6),
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, 5)
		end,
		widget = wibox.container.margin,
	})

	launcher_widget:buttons(gears.table.join(awful.button({}, 1, function()
		awful.spawn(apps.launcher, false)
	end)))

	return launcher_widget
end
