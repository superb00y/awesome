local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")
local textwallpaper = require("modules.textWallpaper")
local screen = screen

local setters = {}

-- Apply wallpaper with maximized positioning across all screens
local function apply_wallpaper(wallpaper_object, args)
  args.background = args.background or beautiful.bg_normal or "black"
  args.ignore_aspect = args.ignore_aspect or false
  args.offset = args.offset or { x = 0, y = 0 }

  local function apply_maximized(s)
    gears.wallpaper.maximized(wallpaper_object, s, args.ignore_aspect, args.offset)
  end

  if type(wallpaper_object) == "string" and gears.filesystem.file_readable(wallpaper_object) then
    for s in screen do
      apply_maximized(s)
    end
  elseif type(wallpaper_object) == "function" then
    wallpaper_object(args)
  else
    gears.wallpaper.set(wallpaper_object)
  end
end

-- Prepare list of wallpapers from directories
local function prepare_wallpaper_list(args)
  args.image_formats = args.image_formats or { "jpg", "jpeg", "png", "bmp" }
  args.recursive = args.recursive ~= false -- Default to true if not specified

  local wallpapers = args.wallpaper or beautiful.wallpaper_path or "black"
  local wallpaper_list = {}

  if type(wallpapers) ~= "table" then
    wallpapers = { wallpapers }
  end

  for _, path in ipairs(wallpapers) do
    if type(path) == "string" and gears.filesystem.dir_readable(path) then
      local file_list = helpers.list_directory_files(path, args.image_formats, args.recursive)
      for _, file in ipairs(file_list) do
        table.insert(wallpaper_list, path .. "/" .. file)
      end
    else
      table.insert(wallpaper_list, path)
    end
  end

  return wallpaper_list
end

local simple_index = 0

function setters.simple(args)
  local wallpapers = prepare_wallpaper_list(args)
  simple_index = (simple_index % #wallpapers) + 1

  apply_wallpaper(wallpapers[simple_index], args)
end

function setters.random(args)
  local wallpapers = prepare_wallpaper_list(args)
  local random_index = math.random(#wallpapers)

  apply_wallpaper(wallpapers[random_index], args)
end

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
      -- textwallpaper.text_wallpaper(colors.bg, colors.accent, text, font, font_size, s),
      textwallpaper.svg_image("/home/youq-chan/.config/awesome/assets/linux.svg", colors.bg, colors.accent, s),
      -- textwallpaper.svg_image("/home/youq-chan/Downloads/1298794.svg", colors.bg, colors.accent, s),
      s,
      args.ignore_aspect
    )
  end
end

function setup(args)
  local config = args or {}
  config.set_function = config.set_function or (config.wallpaper and setters.simple or setters.awesome_wallpaper)

  local function set_wallpaper()
    config.set_function(config)
  end

  if config.change_timer and config.change_timer > 0 then
    gears.timer({
      timeout = config.change_timer,
      call_now = false,
      autostart = true,
      callback = set_wallpaper,
    })
  end

  screen.connect_signal("request::wallpaper", set_wallpaper)
end

return {
  setup = setup,
  setters = setters,
  apply = apply_wallpaper,
  prepare_list = prepare_wallpaper_list,
}
