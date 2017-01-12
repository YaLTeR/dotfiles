local awful   = require("awful")
local wibox   = require("wibox")
local vicious = require("vicious")

wifi = {}

wifi.enabled = true

wifi.widget = wibox.widget.textbox()
wifi.widget:set_font("Liberation Mono 10")
wifi.widget:set_align("right")

wifi.toggle = function()
    wifi.enabled = not wifi.enabled
    cmd = "stop"
    if wifi.enabled then
        cmd = "start"
    end
    os.execute("sudo systemctl " .. cmd .. " netctl-auto@wlp2s0.service &")
    vicious.force({ wifi.widget })
end

wifi.widget:buttons(awful.util.table.join(awful.button({}, 1, nil, wifi.toggle)))

vicious.register(
    wifi.widget,
    vicious.widgets.wifi,
    function(widget, args)
        local ssid = args["{ssid}"]
        if ssid:len() > 32 then
            ssid = ssid:sub(1, 32)
        end

        local symbol
        if wifi.enabled then
            symbol = ""
        else
            symbol = ""
        end

        return " " .. symbol .. " " .. ssid .. " "
    end,
    59,
    "wlp2s0"
)

dbus.request_name("system", "yalter.awesome.wifi")
dbus.add_match("system", "interface='yalter.awesome.wifi'")
dbus.connect_signal(
    "yalter.awesome.wifi",
    function (...)
        local data = { ... }
        local func_name = data[1].member
        
        if func_name == "upPost" then
            vicious.force({ wifi.widget })
        elseif func_name == "downPre" then
            local symbol
            if wifi.enabled then
                symbol = ""
            else
                symbol = ""
            end

            wifi.widget:set_text(" " .. symbol .. " N/A ")
        end
    end
)

return wifi
