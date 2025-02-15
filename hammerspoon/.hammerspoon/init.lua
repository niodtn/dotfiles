local excludeApps = {
    "Moonlight"
}

Hangul = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
    local flags = event:getFlags()
    local keyCode = event:getKeyCode()
    local frontApp = hs.application.frontmostApplication():name()

    for _, app in ipairs(excludeApps) do
        if frontApp == app then
            return false
        end
    end

    if keyCode == hs.keycodes.map["rightcmd"] then
        if flags.cmd then
            hs.eventtap.keyStroke({}, "f19")
        end
        return true
    end
end)

Hangul:start()
