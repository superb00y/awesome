local wallpaper = require("modules.wallpaper")
local beautiful = require("beautiful")

wallpaper.setup({
  change_timer = beautiful.awesome_wall == true and 0 or 900,
  set_function = beautiful.awesome_wall == true and wallpaper.setters.text_wallpaper or wallpaper.setters.random,
  wallpaper = beautiful.wallpapers_path,
  recursive = false,
  ignore_aspect = true,
  text = "superbOOy",
  font = "Another Danger - Demo",
  font_size = 200,
  colors = {
    bg = beautiful.bg_dim,
    fg = beautiful.fg_normal,
    accent = beautiful.accent,
  },
})
