local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")

local dpi = beautiful.xresources.apply_dpi

local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- awful.widget.common.list_update with modifications
local function tasklist_update(w, buttons, label, data, objects)
    -- update the widgets, creating them if needed
    w:reset()
    for i, o in ipairs(objects) do
        local cache = data[o]
        local ib, bgb, tt, container
        if cache then
            ib = cache.ib
            bgb = cache.bgb
            tt = cache.tt
            container = cache.container
        else
            ib = wibox.widget.imagebox()
            local ib_container = wibox.container.place(wibox.container.constraint(ib, "exact", dpi(20), dpi(20)))

            local bar = wibox.container.constraint(nil, "exact", dpi(4), dpi(30))
            bgb = wibox.container.background(bar)

            local l = wibox.layout.fixed.horizontal()
            l:add(wibox.container.constraint(nil, "exact", dpi(5)))
            l:add(ib_container)
            l:add(wibox.container.constraint(nil, "exact", dpi(5)))
            l:add(bgb)

            tt = awful.tooltip({ objects = { l } })

            local v = wibox.container.place(l)
            container = wibox.container.constraint(v, "exact", dpi(40), dpi(40))

            container:buttons(awful.widget.common.create_buttons(buttons, o))

            data[o] = {
                ib  = ib,
                bgb = bgb,
                tt = tt,
                container = container,
            }
        end

        local text, bg, bg_image, icon, args = label(o, tt.textbox)
        args = args or {}

        bgb:set_bg(bg)

        if not tt.textbox:set_markup_silently(text) then
            tt:set_markup("<i>&lt;Invalid text&gt;</i>")
        else
            tt:set_markup(text)
        end

        if icon then
            ib:set_image(icon)
        end

        w:add(container)
   end
end

local tasklist = {}
function tasklist.make(s)
  return awful.widget.tasklist(s,
                               awful.widget.tasklist.filter.currenttags,
                               tasklist_buttons,
                               {
                                  bg_normal = beautiful.bg_focus,
                                  bg_focus = beautiful.fg_normal,
                               },
                               tasklist_update,
                               wibox.layout.fixed.vertical())
end

return tasklist
