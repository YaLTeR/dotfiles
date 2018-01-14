local wibox     = require("wibox")
local vicious   = require("vicious")

cpugraph = wibox.widget.graph()
vicious.register(cpugraph, vicious.widgets.cpu, "$1")

return cpugraph
