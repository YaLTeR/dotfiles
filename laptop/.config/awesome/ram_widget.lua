local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")

ram_widget = wibox.widget.textbox()

ram_widget:set_font("Liberation Mono 10")
ram_widget:set_align("right")

vicious.register(ram_widget, vicious.widgets.mem, "  $1% ", 11)

return ram_widget
