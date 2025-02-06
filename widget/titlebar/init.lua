-- local awful = require("awful")
-- local wibox = require("wibox")
-- local gears = require("gears")
-- local helpers = require("helpers")
-- local beautiful = require("beautiful")
-- local dpi = beautiful.xresources.apply_dpi

-- local createButton = function(c, fn, color)
-- 	local btn = wibox.widget({
-- 		forced_width = dpi(15),
-- 		forced_height = dpi(15),
-- 		bg = color,
-- 		shape = helpers.rrect(5),
-- 		buttons = {
-- 			awful.button({}, 1, function()
-- 				fn(c)
-- 			end),
-- 		},
-- 		widget = wibox.container.background,
-- 	})

-- 	return btn
-- end

-- client.connect_signal("request::titlebars", function(c)
-- 	local close = createButton(c, function(c1)
-- 		c1:kill()
-- 	end, beautiful.red)

-- 	local maximize = createButton(c, function(c1)
-- 		c1.maximized = not c1.maximized
-- 	end, beautiful.yellow)

-- 	local minimize = createButton(c, function(c1)
-- 		gears.timer.delayed_call(function()
-- 			c1.minimized = not c1.minimized
-- 		end)
-- 	end, beautiful.green)

-- 	local buttons = gears.table.join(

-- 		awful.button({}, 1, function()
-- 			client.focus = c
-- 			c:raise()
-- 			awful.mouse.client.move(c)
-- 		end),

-- 		awful.button({}, 3, function()
-- 			client.focus = c
-- 			c:raise()
-- 			awful.mouse.client.resize(c)
-- 		end)
-- 	)

-- 	awful
-- 		.titlebar(c, {
-- 			size = dpi(26),
-- 			position = "top",
-- 		})
-- 		:setup({
-- 			{
-- 				{
-- 					{
-- 						{
-- 							{
-- 								align = "center",
-- 								widget = awful.titlebar.widget.titlewidget(c),
-- 								font = beautiful.font .. "Bold 12",
-- 							},
-- 							spacing = dpi(beautiful.spacing),
-- 							widget = wibox.container.margin,
-- 							visible = true,
-- 							align = "center",
-- 						},
-- 						right = dpi(20),
-- 						left = dpi(20),
-- 						widget = wibox.container.margin,
-- 					},
-- 					nil,
-- 					{
-- 						{
-- 							{
-- 								minimize,
-- 								maximize,
-- 								close,
-- 								spacing = dpi(beautiful.spacing),
-- 								widget = wibox.container.place,
-- 								halign = "center",
-- 								visible = true,
-- 								layout = wibox.layout.fixed.horizontal,
-- 							},
-- 							left = dpi(20),
-- 							right = dpi(20),
-- 							top = dpi(4),
-- 							bottom = dpi(4),
-- 							widget = wibox.container.margin,
-- 						},
-- 						widget = wibox.container.place,
-- 						halign = "center",
-- 					},
-- 					layout = wibox.layout.align.horizontal,
-- 				},
-- 				shape = helpers.rrect(5),
-- 				bg = beautiful.bg_dark,
-- 				fg = beautiful.fg_normal,
-- 				widget = wibox.container.background,
-- 			},
-- 			bottom = dpi(-2),
-- 			widget = wibox.container.margin,
-- 		})
-- end)

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

