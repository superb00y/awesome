local ruled = require("ruled")
local awful = require("awful")
local beautiful = require("beautiful")

ruled.client.connect_signal("request::rules", function()
  ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      raise = true,
      size_hints_honor = false,
      screen = awful.screen.preferred,
      focus = awful.client.focus.filter,
      border_width = beautiful.titlebar_enabled and 0 or beautiful.border,
      placement = function(c)
        awful.placement.centered(c, c.transient_for)
        awful.placement.no_offscreen(c)
      end,
    },
  })

  ruled.client.append_rule({
    id = "floating",
    rule_any = {
      instance = { "copyq", "pinentry" },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
        "feh",
        "qview",
        "ncmpcpp",
        "Places",
      },
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true },
  })

  if beautiful.titlebar_enabled then
    ruled.client.append_rule({
      id = "titlebars",
      rule_any = { type = { "normal" } },
      properties = {
        titlebars_enabled = true,
      },
    })
  end

  ruled.client.append_rule({
    rule_any = { class = { "vivaldi" }, name = { "vivaldi" }, instance = { "vivaldi" } },
    properties = {
      titlebars_enabled = false,
      border_width = 0,
    },
  })
end)
