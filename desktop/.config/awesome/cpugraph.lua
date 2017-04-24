local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")

cpugraph = awful.widget.graph()

cpugraph:set_width(50)
cpugraph:set_background_color("#494B4F")
cpugraph:set_color({
                        type  = "linear",
                        from  = { 0, 0 },
                        to    = { 10,0 },
                        stops = {
                            {0,   "#FF5656"},
                            {0.5, "#88A175"},
                            {1,   "#AECF96" }
                        }
                    })

vicious.register(cpugraph, vicious.widgets.cpu, "$1")

return cpugraph
