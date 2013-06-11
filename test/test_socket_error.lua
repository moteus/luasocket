local socket = require "socket"

local host, port = "127.0.0.1", "5462"

assert(socket.bind(host, port)):close()

socket.sleep(0.5)

local sock = socket.tcp()
sock:settimeout(0)

local ok, err = sock:connect(host, port)
assert(not ok)
assert('timeout' == err)

for i = 1, 10 do
  -- select pass even if socket has error
  local _, rec, err = socket.select(nil, {sock}, 1)
  local _, ss = next(rec)
  assert(ss == nil, "unexpected socket:" .. tostring(ss))
  assert('timeout' == err, 'unexpected error :' .. tostring(err))
  err = sock:getoption("error") -- i get 'connection refused' on WinXP
  if err then
    print("Passed! Error is '" .. err .. "'.")
    os.exit(0)
  end
end

print("Fail! No error detected!")
os.exit(1)
