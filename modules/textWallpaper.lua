local lgi = require("lgi")
local cairo = lgi.cairo
local Pango = lgi.Pango
local PangoCairo = lgi.PangoCairo
local Rsvg = lgi.Rsvg
local gears_color = require("gears.color")
local screen = screen

local M = {}

function M.text_wallpaper(bg, fg, text, font, size, s)
  s = s or screen.primary
  local height = s.geometry.height
  local width = s.geometry.width
  local img = cairo.RecordingSurface.create(
    cairo.Content.COLOR,
    cairo.Rectangle({ x = 0, y = 0, width = width, height = height })
  )
  local cr = cairo.Context.create(img)
  cr:set_source(gears_color(bg))
  cr:paint()

  local layout = PangoCairo.create_layout(cr)

  local font_desc = Pango.FontDescription.from_string(font .. " " .. size)
  layout:set_font_description(font_desc)

  layout:set_text(text)
  local text_width, text_height = layout:get_pixel_size()

  local x = (width - text_width) / 2
  local y = (height - text_height) / 2

  cr:set_source(gears_color(fg))

  cr:move_to(x, y)
  PangoCairo.show_layout(cr, layout)

  cr:fill_preserve()
  cr:set_source(gears_color(fg .. "aa"))
  cr:set_line_width(2.56)

  return img
end

local function read_svg_file(path)
  local file, err = io.open(path, "r")
  if not file then
    error("Failed to open SVG file: " .. err)
  end
  local content = file:read("*all")
  file:close()
  return content
end

function M.svg_image(svg_path, bg, fg, s)
  s = s or screen.primary
  local height = s.geometry.height
  local width = s.geometry.width
  local svg_data = read_svg_file(svg_path)
  local surface = cairo.RecordingSurface.create(
    cairo.Content.COLOR,
    cairo.Rectangle({ x = 0, y = 0, width = width, height = height })
  )
  local cr = cairo.Context.create(surface)
  cr:set_source(gears_color(bg))
  cr:paint()
  local handle, err = Rsvg.Handle.new_from_data(svg_data)
  if not handle then
    error("Failed to parse SVG: " .. tostring(err))
  end
  local dim = handle:get_dimensions()
  local scale = math.min(width / dim.width, height / dim.height) / 4
  local translate_x = (width - (dim.width * scale)) / 2
  local translate_y = (height - (dim.height * scale)) / 2
  cr:save()
  cr:translate(translate_x, translate_y)
  cr:scale(scale, scale)
  cr:push_group()
  handle:render_cairo(cr)
  local pattern = cr:pop_group()
  cr:set_source(gears_color(fg))
  cr:mask(pattern)
  cr:restore()
  return surface
end

return M
