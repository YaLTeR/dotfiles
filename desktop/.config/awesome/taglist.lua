local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

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
        local ib, tb, bgb, tbm, ibm, l
        if cache then
            ib = cache.ib
            tb = cache.tb
            bgb = cache.bgb
            tbm = cache.tbm
            ibm = cache.ibm
        else
            ib = wibox.widget.imagebox()
            tb = wibox.widget.textbox()
            bgb = wibox.container.background()
            tbm = wibox.container.margin(tb, dpi(4), dpi(4))
            ibm = wibox.container.margin(ib, dpi(4))
            l = wibox.layout.fixed.horizontal()

            tb:set_align("center")

            -- All of this is added in a fixed widget
            l:fill_space(true)
            l:add(ibm)
            l:add(tbm)

            v = vertical_constraint(l, 20)

            -- And all of this gets a background
            bgb:set_widget(v)

            bgb:buttons(awful.widget.common.create_buttons(buttons, o))

            data[o] = {
                ib  = ib,
                tb  = tb,
                bgb = bgb,
                tbm = tbm,
                ibm = ibm,
            }
        end

        local text, bg, bg_image, icon, args = label(o, tb)
        args = args or {}

        -- The text might be invalid, so use pcall.
        if text == nil or text == "" then
            tbm:set_margins(0)
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
            ibm:set_margins(0)
        end

        bgb.shape              = args.shape
        bgb.shape_border_width = args.shape_border_width
        bgb.shape_border_color = args.shape_border_color

        w:add(bgb)
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
