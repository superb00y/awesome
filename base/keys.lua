local awful = require("awful")
local home = os.getenv("HOME") .. "/"
local hotkeys_popup = require("awful.hotkeys_popup")
local user = require("user")
local helpers = require("helpers")
local modkey = user.modkey
local modkey2 = user.modkey2

require("awful.autofocus")
require("scripts.screenshot")

awful.keyboard.append_global_keybindings({
  awful.key({ modkey }, "/", function()
    hotkeys_popup.show_help()
  end, { description = "Show keybinds", group = "Awesome" }),

  awful.key({ modkey }, "Return", function()
    awful.spawn(user.terminal)
  end, { description = "Spawn terminal", group = "Awesome" }),

  awful.key({ modkey }, "d", function()
    awful.spawn.with_shell(" rofi -show drun -drun-display-format {name} -theme ~/.config/rofi/simple.rasi ")
  end, { description = "launcher", group = "Apps" }),

  awful.key({ modkey }, "r", function()
    require("widget.bar.promptbar"):toggle()
  end, { description = "run prompt", group = "launcher" }),

  -- awful.key({ modkey }, "x", function()
  --   awful.prompt.run({
  --     prompt = "Run Lua code: ",
  --     textbox = awful.screen.focused().mypromptbox.widget,
  --     exe_callback = awful.util.eval,
  --     history_path = awful.util.get_cache_dir() .. "/history_eval",
  --   })
  -- end, { description = "lua execute prompt", group = "awesome" }),
  -- awful.key(
  --   { modkey, "Shift" },
  --   "d",
  --   awful.screen.focused().prompt,
  --   { description = "Echo a string", group = "custom" }
  -- ),

  awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "Restart awesome", group = "Awesome" }),

  awful.key({ modkey, "Shift" }, "e", awesome.quit, { description = "Exit awesome", group = "Awesome" }),

  -- Tags
  awful.key({ modkey2 }, "Tab", awful.tag.viewnext, { description = "Jump to next tag", group = "Tags" }),

  awful.key({ modkey2, "Shift" }, "Tab", awful.tag.viewprev, { description = "Jump to previous tag", group = "Tags" }),

  awful.key({ modkey }, "numrow", function(i)
    local screen = awful.screen.focused()
    local tag = screen.tags[i]
    if tag then
      tag:view_only()
    end
  end, { description = "Jump to respective number tag", group = "Tags" }),

  awful.key({ modkey, "Shift" }, "numrow", function(i)
    if client.focus then
      local tag = client.focus.screen.tags[i]
      if tag then
        client.focus:move_to_tag(tag)
      end
    end
  end, { description = "Move focused client to tag", group = "Tags" }),

  -- Windows
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.bydirection("down", client.swap)
  end, { description = "Swap below window", group = "Windows" }),

  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.bydirection("up", client.swap)
  end, { description = "Swap above window", group = "Windows" }),

  awful.key({ modkey, "Shift" }, "h", function()
    awful.client.swap.bydirection("left", client.swap)
  end, { description = "Swap with left window", group = "Windows" }),

  awful.key({ modkey, "Shift" }, "l", function()
    awful.client.swap.bydirection("right", client.swap)
  end, { description = "Swap with right window", group = "Windows" }),

  -- Layout
  awful.key({ modkey }, "Tab", function()
    awful.layout.inc(1)
  end, { description = "Cycle between layouts", group = "Layout" }),

  awful.key({ modkey, "Shift" }, "Tab", function()
    awful.layout.inc(-1)
  end, { description = "Reverse cycle between layouts", group = "Layout" }),

  -- Focus
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "Focus on previous tag", group = "Focus" }),

  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "Focus on next tag", group = "Focus" }),

  awful.key({ modkey }, "h", function()
    awful.client.focus.bydirection("left")
  end, { description = "Focus on left window", group = "Focus" }),

  awful.key({ modkey }, "l", function()
    awful.client.focus.bydirection("right")
  end, { description = "Focus on right window", group = "Focus" }),

  -- Screenshot
  awful.key({ modkey }, ";", function()
    awful.spawn.easy_async_with_shell(home .. ".config/awesome/scripts/screenshot full ")
  end, { description = "Screenshot whole screen", group = "Screenshot" }),

  awful.key({ modkey }, ",", function()
    awful.spawn.easy_async_with_shell(home .. ".config/awesome/scripts/screenshot area ")
  end, { description = "Screenshot selection", group = "Screenshot" }),

  awful.key({ modkey, "Shift" }, ";", function()
    awful.spawn.easy_async_with_shell(home .. ".config/awesome/scripts/screenshot active ")
  end, { description = "Screenshot fucosed window", group = "Screenshot" }),

  -- Volume
  awful.key({ nil }, "XF86AudioLowerVolume", function()
    awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-")
  end, { description = "Raise volume", group = "Volume" }),

  awful.key({ nil }, "XF86AudioRaiseVolume", function()
    awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+")
  end, { description = "Decrease volume", group = "Volume" }),

  awful.key({ nil }, "XF86AudioMute", function()
    awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
  end, { description = "Mute volume", group = "Volume" }),
})

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({

    awful.key({ modkey }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { description = "Toggle fullscreen", group = "Awesome" }),

    awful.key({ modkey }, "a", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { description = "Toggle maximized", group = "Awesome" }),

    awful.key({ modkey }, "q", function(c)
      c:kill()
    end, { description = "Kill, rend and slaughter your windows", group = "Awesome" }),

    awful.key({ modkey, "Shift" }, "space", function(c)
      c.floating = not c.floating
      c:raise()
    end, { description = "Toggle floating", group = "Awesome" }),

    awful.key({ modkey, "Control" }, "k", function(c)
      helpers.resize_client(c.focus, "up")
    end, { description = "Resize vertically -- up", group = "Windows" }),

    awful.key({ modkey, "Control" }, "j", function(c)
      helpers.resize_client(c.focus, "down")
    end, { description = "Resize vertically -- down", group = "Windows" }),

    awful.key({ modkey, "Control" }, "h", function(c)
      helpers.resize_client(c.focus, "left")
    end, { description = "Resize horizontally  -- left", group = "Windows" }),

    awful.key({ modkey, "Control" }, "l", function(c)
      helpers.resize_client(c.focus, "right")
    end, { description = "Resize horizontally -- right", group = "Windows" }),
  })
end)

awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { modkey },
    keygroup = "numrow",
    description = "only view tag",
    group = "Tags",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  }),
  awful.key({
    modifiers = { modkey, "Shift" },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "Tags",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  }),
})

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:activate({ context = "mouse_enter", raise = false })
end)

-- awful.mouse.append_global_mousebindings({
--   awful.button({}, 4, awful.tag.viewprev),
--   awful.button({}, 5, awful.tag.viewnext),
--   awful.button({
--     modifiers = {},
--     button = 3,
--     on_press = function()
--       menu.mainMenu:toggle()
--     end,
--   }),
-- })

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({}, 1, function(c)
      c:activate({ context = "mouse_click" })
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate({ context = "mouse_click", action = "mouse_move" })
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate({ context = "mouse_click", action = "mouse_resize" })
    end),
  })
end)
