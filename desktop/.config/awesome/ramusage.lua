local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")

ram_widget = wibox.widget.textbox()
ram_widget:set_align("center")

vicious.register(ram_widget, vicious.widgets.mem, "<span color='#00000088'><b>$1%</b></span>", 2)

return ram_widget
