local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")

freespace = wibox.widget.textbox()
freespace:set_align("right")

vicious.register(freespace, vicious.widgets.fs, "<span color='yellow'>  ${/ avail_gb}G </span>", 3)

return freespace
