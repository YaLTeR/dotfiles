local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")

freespace = wibox.widget.textbox()
freespace:set_align("right")

vicious.register(freespace, vicious.widgets.fs, "  ${/ avail_gb}G ", 3)

return freespace
