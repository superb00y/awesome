local awful = require("awful")
local home = os.getenv("HOME") .. "/"

local User = {}
User.theme = "biscuit"
User.modkey = "Mod4" -- Windows/Super key
User.modkey2 = "Mod1" -- Alt key
User.terminal = "tilix"
User.term_cmd = "tilix -c"
User.browser = os.getenv("BROWSER") or "vivaldi"
User.editor = os.getenv("EDITOR") or "nvim"
User.files = "nemo"
User.anki = "anki"
User.chatapp = "discord"
User.files_cli = "ranger"
User.music_enabled = true
User.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.max.fullscreen,
}

User.tags = { "1", "2", "3", "4", "5" }
User.titlebar = false
User.titlebar_icons = true
User.bar_pos = "bottom"
User.transparent_bar = false
User.dock_enabled = false
User.notification_pos = "top"
User.border = 2
User.inner_gaps = 5
User.outer_gaps = 5
User.style = "semi-rounded"
User.accent = "white"

User.icon = "awm"

User.font = "Iosevka Nerd Font Mono "
User.font_mono = "Iosevka Nerd Font Mono "
User.fontsize = "13"

User.screenshotdir = home .. "Pictures/Screenshots/"
User.username = os.getenv("USER")

return User
