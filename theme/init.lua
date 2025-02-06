local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local gfs = require("gears.filesystem")
local helpers = require("helpers")
local icon_path = gfs.get_configuration_dir() .. "assets/"
local xresources = require("beautiful.xresources")

local _T = {}

local aweicon = "/home/superb00y/.config/awesome/assets/aweicon/moon.svg"

_T.font = "Iosevka Nerd Font Mono "
_T.font_mono = "Iosevka Nerd Font Mono "
_T.fontsize = "13"
_T.spacing = 5
_T.border = dpi(2)
_T.inner_gaps = 5
_T.outer_gaps = 5
_T.tags = { "1", "2", "3", "4", "5" }
_T.titlebar_enabled = true
-- cairo_svg cairo_text awesome_wall
_T.awesome_wall = "cairo_svg"
_T.transparent_bar = true

local function adjust_brightness(color, factor)
	local r = tonumber(color:sub(2, 3), 16)
	local g = tonumber(color:sub(4, 5), 16)
	local b = tonumber(color:sub(6, 7), 16)
	r = math.min(255, math.max(0, math.floor(r * factor)))
	g = math.min(255, math.max(0, math.floor(g * factor)))
	b = math.min(255, math.max(0, math.floor(b * factor)))
	return string.format("#%02x%02x%02x", r, g, b)
end

local color = xresources.get_current_theme()

_T.red = color.color1
_T.orange = color.color9
_T.yellow = color.color3
_T.green = color.color2
_T.cyan = color.color14
_T.lightblue = color.color4
_T.blue = color.color12
_T.purple = color.color5
_T.magenta = color.color13
_T.accent = _T.yellow
_T.bg_dark = adjust_brightness(color.background, 0.5)
_T.bg_dim = adjust_brightness(color.background, 0.7)
_T.bg_normal = color.background
_T.bg_light = adjust_brightness(color.background, 1.1)
_T.mid_dark = adjust_brightness(color.background, 1.2)
_T.mid_normal = adjust_brightness(color.background, 1.3)
_T.mid_light = adjust_brightness(color.foreground, 0.6)
_T.fg_normal = color.foreground
_T.transparent = "#00000000"
-- _T.wallpaper = color.wallpaper

_T.avatar = ".config/awesome/assets/pfp3.jpg"

-- AWM values
-- _T.useless_gap = dpi(_T.inner_gaps)
_T.useless_gap = dpi(2)

_T.border_color_normal = _T.bg_normal .. 50

-- if _T.titlebar_enabled == true then
-- 	_T.border_color_active = _T.bg_light .. 50
-- else
-- 	_T.border_color_active = _T.accent .. 50
-- end

_T.menu_height = dpi(15)
_T.menu_width = dpi(100)

_T.layout_tile = gears.color.recolor_image(icon_path .. "tile.svg", _T.yellow)
_T.layout_max = gears.color.recolor_image(icon_path .. "max.svg", _T.fg_normal)
_T.layout_floating = gears.color.recolor_image(icon_path .. "floating.svg", _T.green)
_T.layout_fullscreen = gears.color.recolor_image(icon_path .. "fullscreen.svg", _T.red)

_T.aweicon = gears.color.recolor_image(aweicon, _T.accent)
_T.awesome_icon = require("beautiful.theme_assets").awesome_icon(dpi(100), _T.accent, _T.bg_dark)

_T.star = gears.color.recolor_image(icon_path .. "/aweicon/star.svg", _T.accent)
_T.cookie = gears.color.recolor_image(icon_path .. "/aweicon/cookie.svg", _T.accent)
_T.moon = gears.color.recolor_image(icon_path .. "/aweicon/moon.svg", _T.accent)
_T.cookie_small = gears.color.recolor_image(icon_path .. "/aweicon/cookie-small.svg", _T.accent)
_T.linux = gears.color.recolor_image(icon_path .. "/aweicon/linux.svg", _T.fg_normal)

_T.shotfull = gears.color.recolor_image(icon_path .. "fullshot.svg", _T.red)
_T.shotarea = gears.color.recolor_image(icon_path .. "areashot.svg", _T.green)
_T.shotareamagick = gears.color.recolor_image(icon_path .. "areamagickshot.svg", _T.blue)
_T.shotactive = gears.color.recolor_image(icon_path .. "activeshot.svg", _T.yellow)
_T.shotactivemagick = gears.color.recolor_image(icon_path .. "activemagickshot.svg", _T.purple)

-- Taglist
_T.taglist_font = _T.font
_T.taglist_bg_focus = _T.accent
_T.taglist_bg_occupied = _T.mid_dark
_T.taglist_bg_empty = _T.bg_light
_T.taglist_bg_urgent = _T.yellow

-- Tasklist
_T.tasklist_bg_focus = _T.bg_light
_T.tasklist_bg_normal = _T.bg_normar

-- Titlebar
_T.titlebar_bg_normal = _T.transparent
_T.titlebar_bg_focus = _T.transparent
_T.titlebar_bg_urgent = _T.transparent

_T.titlebar_fg_normal = _T.fg_normal
_T.titlebar_fg_focus = _T.transparent
_T.titlebar_fg_urgent = _T.transparent

-- Icons
-- _T.icon_theme = color.icon_theme

-- Snap
_T.snap_border_width = dpi(3)
_T.snap_border_radius = dpi(3)
_T.snap_bg = _T.accent
_T.snap_shape = helpers.rrect(0)
_T.snapper_gap = dpi(_T.inner_gaps)

-- Systray
_T.systray_max_rows = 1
_T.systray_icon_spacing = dpi(5)
_T.bg_systray = _T.mid_normal

-- Notifications
_T.notification_spacing = dpi(_T.outer_gaps)

-- Tooltips
_T.tooltip_bg = _T.bg_normal
_T.tooltip_fg = _T.fg_normal
_T.tooltip_opacity = 0

return _T
