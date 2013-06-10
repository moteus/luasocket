local socket = require "socket"
assert(socket.dns.local_addresses)
local port = "5462"

for _, host in ipairs(assert(socket.dns.local_addresses())) do
  io.write("try bind to - ", host, ":", port, " - ")
  assert(socket.bind(host, port)):close()
  io.write("ok\n")
end

print("done!")