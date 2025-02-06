local wibox = require("wibox")
local awful = require("awful")

screen.connect_signal("request::desktop_decoration", function(s)
	if s.index == 1 then
		-- Replace with your actual X11 window ID (in hexadecimal format)
		local window_id = "0x2200000"

		-- Create a widget to embed the X11 window
		local animation_widget = wibox.widget({
			{
				id = "animation_window",
				widget = wibox.widget.base.empty_widget, -- Placeholder
			},
			layout = wibox.layout.stack,
		})

		-- Configure the X11 window embedding
		animation_widget:connect_signal("widget::layout_changed", function()
			-- Set the window to reparent it into the widget
			awful.spawn.easy_async(
				"xdotool windowreparent " .. window_id .. " " .. animation_widget.animation_window.widget.wibox.window,
				function() end
			)
		end)

		s.control_center = wibox({
			screen = s,
			width = 450,
			height = s.geometry.height * 0.9,
			ontop = true,
			visible = true,
		})

		s.control_center:setup({
			animation_widget,
			layout = wibox.layout.fixed.vertical,
		})

		awful.placement.right(s.control_center, {
			margins = { bottom = 90, top = 90 },
		})

		awful.spawn.easy_async("xdotool windowsize " .. window_id .. " 200 200", function() end)
	end
end)
