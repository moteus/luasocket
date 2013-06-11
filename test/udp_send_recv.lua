local socket = require"socket"

local r = assert(socket.udp())
assert(r:settimeout(2))
assert(r:setsockname("*", 5432))
local s = assert(socket.udp())

function test_send_recv(msg)
  local ok, emsg = s:sendto(msg, "127.0.0.1", 5432)
  if ok ~= #msg then print("send of msg failed with:", ok, emsg) end

  ok, emsg = r:receive()

  if ok ~= msg then
    print("fail - receive of msg failed with:", ok, emsg)
    os.exit(1)
  end
end

test_send_recv("hello")
test_send_recv("")

local msg = "123"
ok, emsg = r:sendto(msg, "127.0.0.1", 0)
if ok ~= #msg then print("send of msg failed with:", ok, emsg) end

test_send_recv("hello")

print"done!"