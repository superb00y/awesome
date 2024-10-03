local beautiful = require("beautiful")
local gears = require("gears")
local textwallpaper = require("modules.cairoWallpaper")
local screen = screen

local setters = {}

function setters.awesome_wallpaper(args)
  local colors = {
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal,
    accent = beautiful.red,
  }
  if type(args.colors) == "table" then
    colors.bg = args.colors.bg or colors.bg
    colors.fg = args.colors.fg or colors.fg
    colors.accent = args.colors.accent or colors.accent
  end
  for s in screen do
    gears.wallpaper.maximized(
      beautiful.theme_assets.wallpaper(colors.bg, colors.fg, colors.accent, s),
      s,
      args.ignore_aspect
    )
  end
end

function setters.text_wallpaper(args)
  local colors = {
    bg = beautiful.bg_normal,
    accent = beautiful.red,
  }
  local text = args.text or "awesome"
  local font = args.font or "Hack"
  local font_size = args.fons_size or 200
  if type(args.colors) == "table" then
    colors.bg = args.colors.bg or colors.bg
    colors.accent = args.colors.accent or colors.accent
  end
  for s in screen do
    gears.wallpaper.maximized(
      textwallpaper.text_wallpaper(colors.bg, colors.accent, text, font, font_size, s),
      s,
      args.ignore_aspect
    )
  end
end

function setters.svg_wallpaper(args)
  local colors = {
    bg = beautiful.bg_normal,
    accent = beautiful.red,
  }
  if type(args.colors) == "table" then
    colors.bg = args.colors.bg or colors.bg
    colors.accent = args.colors.accent or colors.accent
  end
  local path = args.path or "/home/youq-chan/.config/awesome/assets/linux.svg"
  for s in screen do
    gears.wallpaper.maximized(textwallpaper.svg_image(path, colors.bg, colors.accent, s), s, args.ignore_aspect)
  end
end

local function setup(args)
  local config = args or {}
  config.set_function = config.set_function or setters.awesome_wallpaper
  local function set_wallpaper()
    config.set_function(config)
  end
  screen.connect_signal("request::wallpaper", set_wallpaper)
end

return {
  setup = setup,
  setters = setters,
}
