local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")

freespace_widget = wibox.widget.textbox()

freespace_widget:set_font("Liberation Mono 10")
freespace_widget:set_align("right")

vicious.register(freespace_widget, vicious.widgets.fs, "  ${/ avail_gb}G ", 12)

return freespace_widget
