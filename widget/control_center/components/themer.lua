local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local user = require("user")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local colors = require("theme.colorscheme")
local scheme = require("user").colorscheme
local helpers = require("helpers")
local gfs = gears.filesystem
local asset_path = gfs.get_configuration_dir() .. "assets/"
local home = os.getenv("HOME") .. "/"

return function()
  local themes = {
    "biscuit",
    "sakura",
    "amarena",
    "everblush",
    "catppuccin",
    "camellia",
    "adwaita",
    "fullerene",
    "chi-tsuki",
    "oxocarbon",
    "skyfall",
    "ship",
    "solarized",
    "stardew",
    "nymph",
    "latte",
    "rose",
    -- "everblush",
    -- "plata",
    -- "everforest",
    -- "tokyonight",
    -- "catppuccin",
    -- "dracula",
    -- "mar",
    -- "nord",
    -- "gruvbox_dark",
    -- "gruvbox_light",
    -- "solarized_dark",
    -- "solarized_light",
    -- "janleigh",
    -- "default",
    -- "wave",
    -- "ephemeral",
  }

  local function indexOf(array, value)
    for i, v in ipairs(array) do
      if v == value then
        return i
      end
    end
    return nil
  end

  local index = indexOf(themes, scheme)

  local M = {
    current = scheme,
    colors = {
      red = colors.red,
      green = colors.green,
      yellow = colors.yellow,
      blue = colors.blue,
      magenta = colors.magenta,
      bg = colors.bg_light,
      fg = colors.fg_normal,
      cursor = colors.cursor,
      icon = colors.icon,
      gtk = colors.gtk,
    },
  }

  function M:previous()
    index = (index - 2) % #themes + 1
    self:getColors(themes[index])
    self:setColors()
  end

  function M:next()
    index = index % #themes + 1
    self:getColors(themes[index])
    self:setColors()
  end

  function M:getColors(scheme)
    scheme = scheme or self.current
    self.colors = require("theme.colorscheme." .. scheme)
    self.current = scheme
  end

  function M:setColors()
    local color_ids = { "red", "blue", "green", "yellow", "magenta", "bg" }
    for _, id in ipairs(color_ids) do
      self.widget:get_children_by_id(id)[1].bg = self.colors[id]
    end
    self.widget:get_children_by_id("bg")[1].bg = self.colors.bg_light
    self.widget:get_children_by_id("name")[1].markup =
      helpers.colorizeText(self.current:gsub("^%l", string.upper), self.colors.fg_normal)

    self.widget:get_children_by_id("additional_info")[1].bg = self.colors.bg_dim
    self.widget:get_children_by_id("theme_text")[1].markup = "GTK Theme: " .. self.colors.gtk

    self.widget:get_children_by_id("icon_image")[1].image = home .. self.colors.icon
    self.widget:get_children_by_id("cursor_image")[1].image = home .. self.colors.cursor
  end

  function M.createButton(icons_path, direction, action, bg_color, icon_color)
    local imagebox = wibox.widget({
      image = gears.color.recolor_image(icons_path, icon_color or colors.fg_normal),
      widget = wibox.widget.imagebox,
      forced_height = dpi(20),
      forced_width = dpi(20),
    })

    local button = wibox.widget({
      {
        {
          imagebox,
          id = "icon_layout",
          widget = wibox.container.place,
        },
        id = "direction_layout",
        direction = direction,
        widget = wibox.container.rotate,
      },
      bg = colors.transparent,
      shape = function(c, w, h)
        gears.shape.rounded_rect(c, w, h, dpi(4))
      end,
      forced_height = dpi(30),
      widget = wibox.container.background,
    })

    button:connect_signal("mouse::enter", function()
      button.bg = bg_color or colors.mid_normal
    end)

    button:connect_signal("mouse::leave", function()
      button.bg = colors.transparent
    end)

    button.buttons = {
      awful.button(nil, 1, action),
    }

    helpers.hoverCursor(button)

    return button
  end

  function M.set_theme(current)
    local config_path = home .. ".config/awesome/user.lua"
    local sed_command = string.format(
      [[sed -i 's/_U.colorscheme = ".*"/_U.colorscheme = "%s"/' %s]],
      current:gsub('"', '\\"'),
      config_path
    )

    local success = os.execute(sed_command)
    if success then
      awesome.restart()
    else
      naughty.notify({
        title = "Error",
        text = "Failed to set the theme " .. current .. "!!!!",
      })
    end
  end

  M.widget = wibox.widget({
    {
      {
        {
          {
            {
              {
                id = "name",
                markup = M.current,
                font = beautiful.font .. " 14",
                widget = wibox.widget.textbox,
              },
              widget = wibox.container.margin,
              buttons = awful.button({}, 1, function()
                M:getColors(scheme)
                M:setColors()
              end),
            },
            id = "bg_title",
            bg = colors.transparent,
            shape = function(cr, width, height)
              gears.shape.rounded_rect(cr, width, height, dpi(4))
            end,
            widget = wibox.container.background,
          },
          nil,
          {
            M.createButton(asset_path .. "default_arrow.svg", "north", function()
              M:previous()
            end, colors.mid_normal, colors.fg_normal),
            M.createButton(asset_path .. "default_arrow.svg", "south", function()
              M:next()
            end, colors.mid_normal, colors.fg_normal),
            M.createButton(asset_path .. "check_default.svg", "north", function()
              M.set_theme(M.current)
            end, colors.mid_normal, colors.fg_normal),
            spacing = dpi(2),
            layout = wibox.layout.fixed.horizontal,
          },
          layout = wibox.layout.align.horizontal,
        },
        {
          {
            id = "red",
            widget = wibox.container.background,
            forced_height = 60,
            forced_width = 60,
            bg = M.colors.red,
            shape = gears.shape.circle,
          },
          {
            id = "green",
            widget = wibox.container.background,
            forced_height = 60,
            forced_width = 60,
            bg = M.colors.green,
            shape = gears.shape.circle,
          },
          {
            id = "yellow",
            widget = wibox.container.background,
            forced_height = 60,
            forced_width = 60,
            bg = M.colors.yellow,
            shape = gears.shape.circle,
          },
          {
            id = "blue",
            widget = wibox.container.background,
            forced_height = 60,
            forced_width = 60,
            bg = M.colors.blue,
            shape = gears.shape.circle,
          },
          {
            id = "magenta",
            widget = wibox.container.background,
            forced_height = 60,
            forced_width = 60,
            bg = M.colors.magenta,
            shape = gears.shape.circle,
          },
          spacing = 12,
          layout = wibox.layout.fixed.horizontal,
        },
        {
          {
            {
              {
                id = "theme_text",
                markup = "theme: ....",
                font = beautiful.font .. " 14",
                widget = wibox.widget.textbox,
              },
              {
                {
                  id = "icon_text",
                  markup = "icon theme: ",
                  font = beautiful.font .. " 14",
                  widget = wibox.widget.textbox,
                },
                {
                  id = "icon_image",
                  image = home .. M.colors.icon,
                  forced_height = dpi(32),
                  forced_width = dpi(32),
                  widget = wibox.widget.imagebox,
                },
                spacing = dpi(8),
                layout = wibox.layout.fixed.horizontal,
              },
              {
                {
                  id = "cursor_text",
                  markup = "cursor: ",
                  font = beautiful.font .. " 14",
                  widget = wibox.widget.textbox,
                },
                {
                  id = "cursor_image",
                  image = home .. M.colors.icon,
                  forced_height = dpi(32),
                  forced_width = dpi(32),
                  widget = wibox.widget.imagebox,
                },
                spacing = dpi(8),
                layout = wibox.layout.fixed.horizontal,
              },
              spacing = dpi(8),
              layout = wibox.layout.fixed.vertical,
            },
            widget = wibox.container.margin,
            margins = dpi(20),
          },

          id = "additional_info",
          shape = user.style == "rounded" and helpers.rrect(14) or user.style == "semi-rounded" and helpers.rrect(9),
          widget = wibox.container.background,
          bg = M.colors.bg,
        },
        layout = wibox.layout.align.vertical,
      },
      widget = wibox.container.margin,
      margins = { top = dpi(10), bottom = dpi(10), left = dpi(30), right = dpi(30) },
    },
    id = "bg",
    forced_height = dpi(300),
    maximal_height = dpi(300),
    shape = user.style == "rounded" and helpers.rrect(15) or user.style == "semi-rounded" and helpers.rrect(10),
    widget = wibox.container.background,
    bg = M.colors.bg,
  })

  M:getColors(scheme)
  M:setColors()

  local bg_title = M.widget:get_children_by_id("bg_title")[1]

  helpers.hoverCursor(bg_title)

  bg_title:connect_signal("mouse::enter", function()
    bg_title.bg = colors.bg_dim
  end)

  bg_title:connect_signal("mouse::leave", function()
    bg_title.bg = colors.transparent
  end)

  return M
end
