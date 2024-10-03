local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local hotkeys_popup = require("awful.hotkeys_popup")
local dpi = beautiful.xresources.apply_dpi
local user = require("user")

-- 'Sections'.
local _S = {}

_S.awesome = {
  {
    "Keybinds",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { "Reload", awesome.restart },
}

_S.power = {
  {
    "Quit",
    function()
      awesome.quit()
    end,
  },
  {
    "Suspend",
    function()
      os.execute("suspend")
    end,
  },
  {
    "Reboot",
    function()
      awful.spawn("reboot")
    end,
  },
  {
    "Shutdown",
    function()
      awful.spawn("poweroff")
    end,
  },
  {
    "Lock",
    function()
      awful.spawn("awesome-client 'lockscreen()'")
    end,
  },
}

-- The widgets to return.
local _M = {}

_M.mainMenu = awful.menu({
  items = {
    { "Terminal", user.terminal },
    { "Browser", user.browser },
    { "Files", user.files },
    { "Anki", user.anki },
    { "Chatapp", user.chatapp },
    { "Awesome", _S.awesome },
    { "Power", _S.power },
  },
  theme = {
    width = dpi(160),
    height = dpi(32),
    bg_normal = beautiful.bg_normal,
    bg_focus = beautiful.bg_light,
    menu_font = beautiful.font_mono .. " 14",
  },
})

_M.mainMenu.wibox:set_widget(wibox.widget({
  widget = wibox.container.background,
  bg = beautiful.bg_normal,
  {
    widget = wibox.container.margin,
    _M.mainMenu.wibox.widget,
  },
}))

awful.menu.original_new = awful.menu.new
function awful.menu.new(...)
  local sub = awful.menu.original_new(...)
  sub.wibox:set_widget(wibox.widget({
    widget = wibox.container.background,
    bg = beautiful.bg_normal,
    {
      widget = wibox.container.margin,
      sub.wibox.widget,
    },
  }))
  return sub
end

return _M
