local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")

freespace = wibox.widget.textbox()
freespace:set_align("center")

vicious.register(freespace, vicious.widgets.fs, "<span color='#00000088'><b>${/ avail_gb}G</b></span>", 3)

return freespace
