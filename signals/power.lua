local awful = require("awful")

awesome.connect_signal("poweroff::toggle", function()
	awesome.emit_signal("controlcenter::toggle")
	awful.spawn("shutdown now")
end)

awesome.connect_signal("reboot::toggle", function()
	awesome.emit_signal("controlcenter::toggle")
	awful.spawn("reboot")
end)

awesome.connect_signal("quit::toggle", function()
	awesome.emit_signal("controlcenter::toggle")
	awesome.quit()
end)

awesome.connect_signal("lock::toggle", function()
	awesome.emit_signal("controlcenter::toggle")
	awful.spawn("awesome-client 'lockscreen()'")
end)
