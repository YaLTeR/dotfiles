local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local vicious   = require("vicious")

cpugraph = wibox.widget.graph()

cpugraph:set_background_color(beautiful.bg_normal)
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
