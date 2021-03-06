local awful = require("awful")
local wibox = require("wibox")

local textclock = {}
textclock.widget = wibox.widget.textclock("<span color='#00000088'><b>%H:%M</b></span>")
textclock.widget:set_align("center")
textclock.tooltip = awful.tooltip({
    objects = { textclock.widget },
    timer_function = function()
        return os.date("%d.%m.%Y\n%A, %B")
    end
})
textclock.tooltip.textbox:set_align("center")

return textclock
