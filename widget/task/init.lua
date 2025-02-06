local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local helpers = require("helpers")
local beautiful = require("beautiful")



screen.connect_signal("request::desktop_decoration", function(s)
local function read_tasks(day)
    local file = io.open("/home/superb00y/tasks/" .. day .. ".txt", "r")
    if not file then return {} end
    local tasks = {}
    for line in file:lines() do
        local time, task = line:match("(%d%d:%d%d)%s+(.*)")
        if time and task then
            table.insert(tasks, {time = time, task = task})
        end
    end
    file:close()
    return tasks
end

local function create_task_tree(tasks)
    local tree = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        spacing = 5,
    }

    for _, task in ipairs(tasks) do
        local task_widget = wibox.widget {
            {
                {
                    text = task.time,
                    widget = wibox.widget.textbox,
                },
                {
                    text = " ├─ " .. task.task,
                    widget = wibox.widget.textbox,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            left = 10,
            widget = wibox.container.margin
        }
        tree:add(task_widget)
    end

    return tree
end

local task_display = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = 10,
}

local function get_current_day()
    return os.date("%A"):lower()
end

local days = {"monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"}

local function update_task_display()
    task_display:reset()

    local current_day = get_current_day()
    local current_day_index = gears.table.find_first_key(days, function(v) return v == current_day end)

    for i = current_day_index, #days do
        local day = days[i]
        local tasks = read_tasks(day)
        if #tasks > 0 then
            task_display:add(wibox.widget {
                {
                    markup = "<b>" .. day:gsub("^%l", string.upper) .. "</b>",
                    widget = wibox.widget.textbox,
                },
                create_task_tree(tasks),
                layout = wibox.layout.fixed.vertical,
            })
        end
    end

    for i = 1, current_day_index - 1 do
        local day = days[i]
        local tasks = read_tasks(day)
        if #tasks > 0 then
            task_display:add(wibox.widget {
                {
                    markup = "<b>" .. day:gsub("^%l", string.upper) .. "</b>",
                    widget = wibox.widget.textbox,
                },
                create_task_tree(tasks),
                layout = wibox.layout.fixed.vertical,
            })
        end
    end
end

-- Create a timer to update the task display every 5 minutes
gears.timer {
    timeout   = 300,
    call_now  = true,
    autostart = true,
    callback  = update_task_display
}

-- Create a container for the task display
local task_display_container = wibox.container.background(task_display)
task_display_container.bg = "#222222"
task_display_container.fg = "#DDDDDD"

-- Create a scroll container for the task display
local scroll_container = wibox.container.scroll.vertical(task_display_container)
scroll_container.step_function = wibox.container.scroll.step_functions.linear_increase
scroll_container.speed = 100
scroll_container.extra_padding = 10


	s.control_center = wibox({
		screen = s,
		width = dpi(450),
		height = s.geometry.height * 0.9,
		shape = helpers.Rrrect(15) ,
		bg = beautiful.bg_dark,
		ontop = true,
		visible = true,
	})
	s.control_center:setup({
    scroll_container,
		expand = "none",
		spacing = dpi(25),
    layout = wibox.layout.flex.horizontal
	})
	awful.placement.right(s.control_center, {
		margins = { bottom = 90, top = 90 },
	})
end)

