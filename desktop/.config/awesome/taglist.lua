local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

-- awful.widget.common.list_update with modifications
local function taglist_update(w, buttons, label, data, objects)
    -- update the widgets, creating them if needed
    w:reset()
    for i, o in ipairs(objects) do
        local cache = data[o]
        local tb, bgb, bgc
        if cache then
            tb = cache.tb
            bgb = cache.bgb
            bgc = cache.bgc
        else
            tb = wibox.widget.textbox()
            tb:set_align("center")

            local bar = wibox.container.constraint(nil, "exact", dpi(2), dpi(15))
            bgb = wibox.container.background(bar)

            local bar_l = wibox.layout.fixed.horizontal()
            bar_l:add(wibox.container.constraint(nil, "exact", dpi(2)))
            bar_l:add(wibox.container.place(bgb))
            local m = wibox.container.mirror(bar_l, { horizontal = true })

            local l = wibox.layout.stack()
            l:add(m)
            l:add(tb)

            local v = vertical_constraint(l, 20)

            bgc = wibox.container.background(v)
            bgc:buttons(awful.widget.common.create_buttons(buttons, o))

            data[o] = {
                tb  = tb,
                bgb = bgb,
                bgc = bgc,
            }
        end

        local text, bg, bg_image, icon, args = label(o, tb)
        args = args or {}

        bgb:set_bg(bg)

        if bg == beautiful.taglist_bg_focus then
          bgc:set_bg("#ffffff11")
        else
          bgc:set_bg("#ffffff00")
        end

        -- The text might be invalid, so use pcall.
        if text == nil or text == "" then
        else
            if not tb:set_markup_silently(text) then
                tb:set_markup("<i>&lt;Invalid text&gt;</i>")
            end
        end

        w:add(bgc)
   end
end

local taglist = {}
function taglist.make(s)
  return awful.widget.taglist(s,
                              awful.widget.taglist.filter.all,
                              taglist_buttons,
                              {},
                              taglist_update,
                              wibox.layout.fixed.vertical())
end

return taglist
