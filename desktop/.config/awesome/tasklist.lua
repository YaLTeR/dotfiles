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
        local ib, tb, bgb, c2
        if cache then
            ib = cache.ib
            tb = cache.tb
            bgb = cache.bgb
            c2 = cache.c2
        else
            tb = wibox.widget.textbox()

            ib = wibox.widget.imagebox()
            i_c = wibox.container.constraint(ib, "exact", dpi(20), dpi(20))
            i_p = wibox.container.place(i_c)

            bar_c = wibox.container.constraint(nil, "exact", dpi(4), dpi(30))
            bgb = wibox.container.background(bar_c)

            l = wibox.layout.fixed.horizontal()
            l:add(wibox.container.constraint(nil, "exact", dpi(5)))
            l:add(i_p)
            l:add(wibox.container.constraint(nil, "exact", dpi(5)))
            l:add(bgb)

            v = wibox.container.place(l)
            c2 = wibox.container.constraint(v, "exact", dpi(40), dpi(40))

            c2:buttons(awful.widget.common.create_buttons(buttons, o))

            data[o] = {
                ib  = ib,
                tb  = tb,
                bgb = bgb,
                c2 = c2,
            }
        end

        local text, bg, bg_image, icon, args = label(o, tb)
        args = args or {}

        -- The text might be invalid, so use pcall.
        if text == nil or text == "" then
            -- tbm:set_margins(0)
        else
            if not tb:set_markup_silently(text) then
                tb:set_markup("<i>&lt;Invalid text&gt;</i>")
            end
        end
        bgb:set_bg(bg)
        if type(bg_image) == "function" then
            -- TODO: Why does this pass nil as an argument?
            bg_image = bg_image(tb,o,nil,objects,i)
        end
        bgb:set_bgimage(bg_image)
        if icon then
            ib:set_image(icon)
        else
            -- ibm:set_margins(0)
        end

        bgb.shape              = args.shape
        bgb.shape_border_width = args.shape_border_width
        bgb.shape_border_color = args.shape_border_color

        w:add(c2)
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
