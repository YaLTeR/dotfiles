libinput:register({1})
libinput:connect("new-evdev-device", function (device)
    local info = device:info()
    if info.vid == 0x046D and info.pid == 0xC099 then
        device:disable_feature("wheel-debouncing")
        device:connect("evdev-frame", function (device, frame, timestamp)
            for _, event in ipairs(frame) do
                if event.usage == evdev.REL_WHEEL_HI_RES then
                    event.value = event.value / 8
                end
            end
            return frame
        end)
    end
end)
