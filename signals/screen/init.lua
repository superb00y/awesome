local wallpaper = require("modules.wallpaper")
local beautiful = require("beautiful")

wallpaper.setup({
  set_function = beautiful.awesome_wall == "cairo_text" and wallpaper.setters.text_wallpaper
    or (
      beautiful.awesome_wall == "cairo_svg" and wallpaper.setters.svg_wallpaper or wallpaper.setters.awesome_wallpaper
    ),
  recursive = false,
  ignore_aspect = true,
  text = "superbOOy",
  font = "Another Danger - Demo",
  font_size = 200,
  path = "/home/youq-chan/.config/awesome/assets/linux.svg",
  colors = {
    bg = beautiful.bg_dim,
    fg = beautiful.fg_normal,
    accent = beautiful.accent,
  },
})
