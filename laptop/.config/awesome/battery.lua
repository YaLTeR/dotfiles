local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local battery = {}

battery.widget = wibox.widget.textbox()
battery.widget:set_font("Liberation Mono 10")

battery.tooltip = awful.tooltip({ objects = { battery.widget } })

local function update_battery_info(adapter)
    local fcur = io.open("/sys/class/power_supply/" .. adapter .. "/charge_now")    
    local fcap = io.open("/sys/class/power_supply/" .. adapter .. "/charge_full")
    local fsta = io.open("/sys/class/power_supply/" .. adapter .. "/status")
    local cur = fcur:read()
    local cap = fcap:read()
    local sta = fsta:read()
    fcur:close()
    fcap:close()
    fsta:close()

    local battery_value = math.floor(cur * 100 / cap)

    local battery_text = ""
    local dir = ""

    if sta:match("Charging") then
        dir = ""
        if battery_value > 50 then
            battery_text = "<span color='green'>"  .. battery_value .. "%" .. "</span>"
        elseif battery_value > 25 then
            battery_text = "<span color='orange'>" .. battery_value .. "%" .. "</span>"
        else
            battery_text = "<span color='red'>"    .. battery_value .. "%" .. "</span>"
        end
    elseif sta:match("Discharging") then
        dir = ""
        if battery_value > 80 then
            battery_text = ""
        elseif battery_value > 60 then
            battery_text = ""
        elseif battery_value > 40 then
            battery_text = ""
        elseif battery_value > 20 then
            battery_text = ""
        else
            if battery_value < 10 then
                naughty.notify({
                    title    = "Battery Warning",
                    text     = "Low battery! " .. battery_value .. "% left!",
                    timeout  = 5,
                    position = "top_right",
                    fg       = beautiful.fg_focus,
                    bg       = beautiful.bg_focus
                })
            end

            battery_text = "" 
        end
    else
        dir = ""
        battery_text = ""
    end

    battery.widget:set_markup(" " .. dir .. battery_text)
    battery.tooltip:set_text(battery_value .. "% - " .. sta)
 end

battery.timer = gears.timer({timeout = 31})
battery.timer:connect_signal("timeout", function()
                                            update_battery_info("BAT0")
                                        end)
battery.timer:start()

update_battery_info("BAT0")

return battery
