local awful = require("awful")
local wibox = require("wibox")

-- http://lua-users.org/wiki/StringTrim
function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local keyboardlayout = {}
keyboardlayout.original_widget = awful.widget.keyboardlayout()
keyboardlayout.original_widget.widget:set_align("center")
keyboardlayout.imagebox = wibox.widget.imagebox()
keyboardlayout.widget = {
                          layout = wibox.layout.stack,
                          keyboardlayout.original_widget,
                          keyboardlayout.imagebox,
                        }

local current_text = keyboardlayout.original_widget.widget.text
local original_set_text = keyboardlayout.original_widget.widget.set_text

function keyboardlayout.original_widget.widget:set_text(text)
  if keyboardlayout.imagebox:set_image(home .. "/.config/awesome/" .. trim(text) .. ".png") then
    keyboardlayout.imagebox:set_opacity(1)
  else
    keyboardlayout.imagebox:set_opacity(0)
  end

  original_set_text(self, text)
end

keyboardlayout.original_widget.widget:set_text(current_text)

return keyboardlayout
