local awful = require("awful")
local wibox = require("wibox")

-- Keyboard map indicator and changer
local kbdcfg = {}

kbdcfg.layout = { { "us", "us flag.png" }, { "ru", "ru flag.png" } } 
kbdcfg.current = 1 -- us is the default.

kbdcfg.widget = wibox.widget.imagebox()
kbdcfg.widget:set_image(os.getenv("HOME") .. "/.config/awesome/" .. kbdcfg.layout[kbdcfg.current][2])

kbdcfg.switch = function ()
    kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
    local t = kbdcfg.layout[kbdcfg.current]
    kbdcfg.widget:set_image(os.getenv("HOME") .. "/.config/awesome/" .. t[2])
    os.execute("setxkbmap " .. t[1])
    os.execute("numlockx off")
    os.execute("numlockx on")
end

-- Mouse bindings
kbdcfg.widget:buttons(
    awful.util.table.join(awful.button({}, 1, nil, function () kbdcfg.switch() end))
)

return kbdcfg
