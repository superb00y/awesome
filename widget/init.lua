local beautiful = require("beautiful")

require("widget.notifications")
if beautiful.titlebar_enabled == true then
  require("widget.titlebar")
end
require("widget.bar")
-- if user.music_enabled == true then
-- 	require("widget.music")
-- end

-- require("widget.control_center")
