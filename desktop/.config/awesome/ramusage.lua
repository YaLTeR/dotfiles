local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")

ram_widget = wibox.widget.textbox()
ram_widget:set_align("right")

vicious.register(ram_widget, vicious.widgets.mem, "<span color='orange'>  $1% </span>", 2)

return ram_widget
