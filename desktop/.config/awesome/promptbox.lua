local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")

local dpi = beautiful.xresources.apply_dpi
local gfs = gears.filesystem

local promptbox = {}
function promptbox.make(s)
  local box = wibox({ screen = s,
                      x = dpi(40 + 2 * beautiful.useless_gap),
                      y = 0,
                      width = s.workarea.width - dpi(40 + 4 * beautiful.useless_gap),
                      height = dpi(20),
                      ontop = true,
                      visible = false })

  box.prompt = awful.widget.prompt()

  box:setup { layout = wibox.layout.fixed.horizontal,
              box.prompt }

  function box:spawn_and_handle_error(...)
    local result = awful.util.spawn(...)
    if type(result) == "string" then
      self.prompt.widget:set_text(result)
      gears.timer.start_new(3, function() self.visible = false end)
    else
      self.visible = false
    end
  end

  function box:eval_and_handle_error(...)
    self.visible = false
    local result = awful.util.eval(...)
  end

  function box:run()
    self.visible = true

    awful.prompt.run {
      prompt              = self.prompt.prompt,
      textbox             = self.prompt.widget,
      completion_callback = awful.completion.shell,
      history_path        = gfs.get_cache_dir() .. "/history",
      exe_callback        = function(...)
        self:spawn_and_handle_error(...)
      end,
    }
  end

  function box:run_lua()
    self.visible = true

    awful.prompt.run {
      prompt       = "Run Lua code: ",
      textbox      = self.prompt.widget,
      exe_callback = function(...)
        self:eval_and_handle_error(...)
      end,
      history_path = gfs.get_cache_dir() .. "/history_eval"
    }
  end

  return box
end

return promptbox
