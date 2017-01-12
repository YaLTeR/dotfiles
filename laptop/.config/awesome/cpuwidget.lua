local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")

cpuwidget = awful.widget.graph()

cpuwidget:set_width(50)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color({
                        type  = "linear",
                        from  = { 0, 0 },
                        to    = { 10,0 },
                        stops = {
                            {0,   "#FF5656"},
                            {0.5, "#88A175"},
                            {1,   "#AECF96" }
                        }
                    })

vicious.register(cpuwidget, vicious.widgets.cpu, "$1")

return cpuwidget
