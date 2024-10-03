local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local user = require("user")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")

local img_path = os.getenv("HOME") .. "/.config/awesome/assets/"

return function()
	local create_buttons = function(image, clr, signal)
		local button = wibox.widget({
			{
				{
					{
						image = img_path .. image,
						forced_width = dpi(25),
						forced_height = dpi(25),
						widget = wibox.widget.imagebox,
					},
					margins = dpi(15),
					widget = wibox.container.margin,
				},
				layout = wibox.container.place,
			},
			id = "back",
			shape = user.style == "rounded" and gears.shape.circle
				or user.style == "semi-rounded" and helpers.rrect(8)
				or gears.shape.rectangle,
			widget = wibox.container.background,
			bg = clr,

			buttons = { awful.button({}, 1, function()
				awesome.emit_signal(signal .. "::toggle")
			end) },
		})

		awesome.connect_signal("signal::" .. signal, function(status)
			button:get_children_by_id("back")[1].bg = status and clr or beautiful.red
		end)

		helpers.hoverCursor(button)
		return button
	end

	local buttons = {
		wifi = create_buttons("wifi.svg", beautiful.yellow, "network"),
		bluetooth = create_buttons("bluetooth.svg", beautiful.yellow, "bluetooth"),
		dnd = create_buttons("dnd2.png", beautiful.yellow, "dnd"),
		-- dark_mode = create_buttons("dark.png", color.red, "Dark mode", "dark_mode"),
		silent = create_buttons("volume-off.svg", beautiful.yellow, "silent"),
		night_mode = create_buttons("dnd.png", beautiful.yellow, "night_mode"),
		settings = create_buttons("settings.png", beautiful.yellow, "settings"),
	}

	local function create_separator()
		return wibox.widget({
			orientation = "vertical",
			forced_width = dpi(10),
			widget = wibox.widget.container,
		})
	end

	local layout = wibox.layout.fixed.horizontal()

	for _, button in pairs(buttons) do
		layout:add(button)
		layout:add(create_separator())
	end

	local main = wibox.widget({
		nil,
		layout,
		nil,
		expand = "none",
		layout = wibox.layout.align.horizontal,
	})

	return main
end
