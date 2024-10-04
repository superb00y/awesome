local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local gfs = require("gears.filesystem")
local helpers = require("helpers")
local path = gfs.get_themes_dir()
local icon_path = gfs.get_configuration_dir() .. "assets/"

local _T = {}

-- color list: everbluesh catppuccin gruvbox_dark biscuit
-- amarena tokyonight adwaita oxocarbon nigthowl
_T.theme = "nightowl"
local color = require("theme.color").return_theme(_T.theme)

_T.font = "Iosevka Nerd Font Mono "
_T.font_mono = "Iosevka Nerd Font Mono "
_T.fontsize = "13"
_T.spacing = 5
_T.border = dpi(3)
_T.inner_gaps = 5
_T.outer_gaps = 5
_T.tags = { "1", "2", "3", "4", "5" }
_T.titlebar_enabled = true
-- cairo_svg cairo_text awesome_wall
_T.awesome_wall = "cairo_svg"
_T.transparent_bar = true

_T.red = color.red
_T.orange = color.orange
_T.yellow = color.yellow
_T.green = color.green
_T.cyan = color.cyan
_T.lightblue = color.lightblue
_T.blue = color.blue
_T.purple = color.purple
_T.magenta = color.magenta
_T.accent = color.accent
_T.bg_dark = color.bg_dark
_T.bg_dim = color.bg_dim
_T.bg_normal = color.bg_normal
_T.bg_light = color.bg_light
_T.mid_dark = color.mid_dark
_T.mid_normal = color.mid_normal
_T.mid_light = color.mid_light
_T.fg_normal = color.fg_normal
_T.transparent = "#00000000"
_T.wallpaper = color.wallpaper
_T.avatar = color.avatar

-- AWM values
_T.useless_gap = dpi(_T.inner_gaps)

_T.border_color_normal = color.bg_normal .. 50

if _T.titlebar_enabled == true then
  _T.border_color_active = color.bg_light .. 50
else
  _T.border_color_active = _T.accent .. 50
end

_T.menu_height = dpi(15)
_T.menu_width = dpi(100)

_T.layout_tile = gears.color.recolor_image(icon_path .. "tile.svg", color.yellow)
_T.layout_max = gears.color.recolor_image(icon_path .. "max.svg", color.fg_normal)
_T.layout_floating = gears.color.recolor_image(icon_path .. "floating.svg", color.green)
_T.layout_fullscreen = gears.color.recolor_image(icon_path .. "fullscreen.svg", color.red)

_T.aweicon = gears.color.recolor_image(color.aweicon, _T.accent)
_T.awesome_icon = require("beautiful.theme_assets").awesome_icon(dpi(100), _T.accent, color.bg_dark)

_T.star = gears.color.recolor_image(icon_path .. "/aweicon/star.svg", _T.accent)
_T.cookie = gears.color.recolor_image(icon_path .. "/aweicon/cookie.svg", _T.accent)
_T.moon = gears.color.recolor_image(icon_path .. "/aweicon/moon.svg", _T.accent)
_T.cookie_small = gears.color.recolor_image(icon_path .. "/aweicon/cookie-small.svg", _T.accent)
_T.linux = gears.color.recolor_image(icon_path .. "/aweicon/linux.svg", _T.fg_normal)

_T.shotfull = gears.color.recolor_image(icon_path .. "fullshot.svg", color.red)
_T.shotarea = gears.color.recolor_image(icon_path .. "areashot.svg", color.green)
_T.shotareamagick = gears.color.recolor_image(icon_path .. "areamagickshot.svg", color.blue)
_T.shotactive = gears.color.recolor_image(icon_path .. "activeshot.svg", color.yellow)
_T.shotactivemagick = gears.color.recolor_image(icon_path .. "activemagickshot.svg", color.purple)

-- Taglist
_T.taglist_font = _T.font
_T.taglist_bg_focus = _T.accent
_T.taglist_bg_occupied = color.mid_dark
_T.taglist_bg_empty = color.bg_light
_T.taglist_bg_urgent = color.yellow

-- Tasklist
_T.tasklist_bg_focus = color.bg_light
_T.tasklist_bg_normal = color.bg_normar

-- Titlebar
_T.titlebar_bg_normal = _T.transparent
_T.titlebar_bg_focus = _T.transparent
_T.titlebar_bg_urgent = _T.transparent

_T.titlebar_fg_normal = _T.fg_normal
_T.titlebar_fg_focus = _T.transparent
_T.titlebar_fg_urgent = _T.transparent

-- Icons
_T.icon_theme = color.icon_theme

-- Snap
_T.snap_border_width = dpi(3)
_T.snap_border_radius = dpi(3)
_T.snap_bg = _T.accent
_T.snap_shape = helpers.rrect(0)
_T.snapper_gap = dpi(_T.inner_gaps)

-- Systray
_T.systray_max_rows = 1
_T.systray_icon_spacing = dpi(5)
_T.bg_systray = color.systray

-- Notifications
_T.notification_spacing = dpi(_T.outer_gaps)

-- Tooltips
_T.tooltip_bg = color.bg_normal
_T.tooltip_fg = color.fg_normal
_T.tooltip_opacity = 0

return _T
