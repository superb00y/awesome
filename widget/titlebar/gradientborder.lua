local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local cairo = require("lgi").cairo
local gears_color = require("gears.color")

-- Configuration
local border_width = 2
local gradient_colors = {
	beautiful.red,
	beautiful.orange,
	beautiful.yellow,
	beautiful.green,
	beautiful.cyan,
	beautiful.lightblue,
	beautiful.blue,
	beautiful.purple,
	beautiful.magenta,
}

local function parse_color(color)
	return gears.color.parse_color(color)
end

local function create_gradient_border(c)
	local border = wibox.widget({
		draw = function(self, _, cr, width, height)
			local pattern = cairo.Pattern.create_linear(0, 0, width, height)

			for i, color in ipairs(gradient_colors) do
				local stop = (i - 1) / (#gradient_colors - 1)
				local r, g, b = parse_color(color)
				pattern:add_color_stop_rgb(stop, r, g, b)
			end
			cr:set_source(pattern)
			cr:set_line_width(border_width)
			cr:rectangle(border_width / 2, border_width / 2, width - border_width, height - border_width)
			cr:stroke()
		end,
		layout = wibox.widget.base.make_widget,
	})
	return border
end

client.connect_signal("request::titlebars", function(c)
	if c.gradient_border then
		return
	end
	c.gradient_border = create_gradient_border(c)

	awful.titlebar(c, { position = "left", size = border_width }):setup({
		create_gradient_border(c),
		layout = wibox.layout.flex.horizontal,
	})
end)

