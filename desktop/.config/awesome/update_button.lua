local awful =  require("awful")
local gtable = require("gears.table")
local wibox =  require("wibox")

local update_button = {}
update_button.text = "<span color='#00000088'><b></b></span>"
update_button.widget = wibox.widget.textbox(update_button.text)
update_button.widget:set_align("center")
update_button.run_update = function()
  awful.util.spawn(terminal .. " -e bash update.sh")
end

update_button.widget:buttons(
  gtable.join(awful.button({ }, 1, update_button.run_update))
)

-- update_button.widget:connect_signal("mouse::enter", function(self)
--   self:set_markup("<span color=\"lightgreen\">" .. update_button.text .. "</span>")
-- end)
-- update_button.widget:connect_signal("mouse::leave", function(self)
--   self:set_text(update_button.text)
-- end)

return update_button
