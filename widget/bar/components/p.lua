local json = require("lunajson")
local http = require("socket.http")
local ltn12 = require("ltn12")
local os = require("os")

local M = {}
function M.get_prayers_time(latitude, longitude, method, offset)
  local date = os.date("*t")

  local url = string.format(
    "http://api.aladhan.com/v1/timings/%s-%s-%s?latitude=%s&longitude=%s&method=%s&adjustments=%s,%s,%s,%s,%s",
    date.year,
    date.month,
    date.day,
    latitude,
    longitude,
    method,
    offset.fajr,
    offset.dhuhr,
    offset.asr,
    offset.maghrib,
    offset.isha
  )
  local res = {}
  local _, status = http.request({
    url = url,
    sink = ltn12.sink.table(res),
  })

  if status ~= 200 then
    return nil, "Failed to fetch data from the server"
  end

  local output = json.decode(table.concat(res))
  local prayers = output.data.timings

  local result = {}
  for k, v in pairs(prayers) do
    local time = v:match("%d+:%d+")
    result[string.lower(k)] = time
  end

  return result
end
return M

-- local latitude = 40.7128
-- local longitude = -74.0060

-- local prayers = get_prayers_times(latitude, longitude, false, 2)
-- for k, v in pairs(prayers) do
-- 	print(k, v)
-- end
