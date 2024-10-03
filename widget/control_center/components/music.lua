local gears = require("gears")
local awful = require("awful")
local user = require("user")
local beautiful = require("beautiful")
local wibox = require("wibox")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

return function()
	local music_art = wibox.widget({
		image = gears.filesystem.get_configuration_dir() .. "assets/cookie3.svg",
		resize = true,
		opacity = 0.4,
		halign = "center",
		valign = "center",
		widget = wibox.widget.imagebox,
	})

	local music_text = wibox.widget({
		markup = helpers.colorizeText("Nothing Playing", beautiful.green),
		font = beautiful.font .. "12",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local music_title = wibox.widget({
		markup = "No Title",
		font = beautiful.font .. "Bold 12",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local music_artist = wibox.widget({
		markup = helpers.colorizeText("No Artist", beautiful.yellow),
		font = beautiful.font .. "Bold 11",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local music_bar = wibox.widget({

		bar_height = dpi(3),
		forced_height = dpi(3),
		bar_color = beautiful.mid_dark,
		bar_active_color = beautiful.blue,

		max_value = 100,
		value = 0,

		color = beautiful.accent,
		background_color = beautiful.bg_dark,
		widget = wibox.widget.progressbar,
	})

	local music_pos = wibox.widget({
		font = beautiful.font .. "Bold 10",
		valign = "center",
		widget = wibox.widget.textbox,
	})

	local control_button_bg = beautiful.transparent
	local control_button_bg_hover = beautiful.bg_dark

	local control_button = function(c, symbol, color, on_click, on_right_click)
		local icon = wibox.widget({
			markup = helpers.colorizeText(symbol, color),
			font = beautiful.font,
			align = "center",
			valign = "center",
			widget = wibox.widget.textbox(),
		})

		local button = wibox.widget({
			icon,
			width = dpi(80),
			height = dpi(80),
			bg = control_button_bg,
			shape = helpers.rrect(dpi(4)),
			widget = wibox.container.background,
		})

		local container = wibox.widget({
			button,
			width = dpi(20),
			height = dpi(20),
			strategy = "min",
			widget = wibox.container.constraint,
		})

		container:buttons(gears.table.join(awful.button({}, 1, on_click), awful.button({}, 3, on_right_click)))
		container:connect_signal("mouse::enter", function()
			button.bg = control_button_bg_hover
		end)
		container:connect_signal("mouse::leave", function()
			button.bg = control_button_bg
		end)
		return container
	end

	local music_play_pause = control_button(c, "󰏤", beautiful.fg_normal, function()
		awful.spawn.with_shell("playerctl play-pause")
	end)

	local music_play_previous = control_button(c, "󰒮", beautiful.fg_normal, function()
		awful.spawn.with_shell("playerctl previous")
	end)

	local music_play_next = control_button(c, "󰒭", beautiful.fg_normal, function()
		awful.spawn.with_shell("playerctl next")
	end)

	local music_play_pause_textbox = music_play_pause:get_all_children()[1]:get_all_children()[1]

	local music = wibox.widget({
		{
			{
				{

					{
						music_text,
						{
							step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
							speed = 50,
							{
								widget = music_title,
							},
							forced_width = dpi(270),
							widget = wibox.container.scroll.horizontal,
						},
						{
							step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
							speed = 50,
							{
								widget = music_artist,
							},
							widget = wibox.container.scroll.horizontal,
						},
						spacing = dpi(3),
						layout = wibox.layout.fixed.vertical,
					},
					nil,
					{
						music_art,
						forced_height = dpi(60),
						forced_width = dpi(60),
						widget = wibox.container.margin,
					},
					spacing = dpi(10),
					layout = wibox.layout.align.horizontal,
				},
				margins = dpi(9),
				widget = wibox.container.margin,
			},
			music_bar,
			music_pos,
			{
				music_play_previous,
				music_play_pause,
				music_play_next,
				forced_height = dpi(40),
				forced_width = dpi(40),
				layout = wibox.layout.flex.horizontal,
			},
			spacing = dpi(9),
			layout = wibox.layout.fixed.vertical,
		},
		margins = dpi(9),
		widget = wibox.container.margin,
	})

	local playerctl = require("modules.bling").signal.playerctl.lib()

	playerctl:connect_signal("metadata", function(_, title, artist, album_path, __, ___, ____)
		if title == "" then
			title = "No Title"
		end
		if artist == "" then
			artist = "No Artist"
		end
		if album_path == "" then
			album_path = gears.filesystem.get_configuration_dir() .. "assets/cookie3.svg"
		end

		music_art:set_image(gears.surface.load_uncached(album_path))
		music_title:set_markup_silently(title)
		music_artist:set_markup_silently(helpers.colorizeText(artist, beautiful.red))
	end)

	playerctl:connect_signal("position", function(_, interval_sec, length_sec, ____)
		local pos_now = tostring(os.date("!%M:%S", math.floor(interval_sec)))
		local pos_length = tostring(os.date("!%M:%S", math.floor(length_sec)))
		local pos_markup = pos_now .. helpers.colorizeText(" / " .. pos_length, beautiful.accent)
		music_pos:set_markup_silently(pos_markup)
		music_bar.value = (interval_sec / length_sec) * 100
	end)

	playerctl:connect_signal("playback_status", function(_, playing, __)
		if playing then
			music_text:set_markup_silently(helpers.colorizeText("Now Playing", beautiful.green))
			music_play_pause_textbox:set_markup_silently("󰏤")
		else
			music_text:set_markup_silently(helpers.colorizeText("Music", beautiful.green))
			music_play_pause_textbox:set_markup_silently("󰐊")
		end
	end)

	local music_boxed = wibox.widget({
		music,
		bg = beautiful.bg_light,
		forced_height = dpi(190),
		shape = user.style == "rounded" and helpers.rrect(15) or user.style == "semi-rounded" and helpers.rrect(10),
		widget = wibox.container.background,
	})

	return music_boxed
end
