local awful = require("awful")
local wibox = require("wibox")

local textclock = {}
textclock.widget = awful.widget.textclock(" %H:%M")
textclock.tooltip = awful.tooltip({
    objects = { textclock.widget },
    timer_function = function()
        return os.date("%d.%m.%Y\n%A, %B")
    end
})
textclock.tooltip.textbox:set_align("center")

return textclock
