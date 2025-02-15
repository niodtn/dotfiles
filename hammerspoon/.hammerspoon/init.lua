local excludeApps = {
    "Moonlight"  -- Exclude Moonlight app
}

-- Switch between Hangul and English
function toggleHangulInput()
    local inputSources = hs.keycodes.inputSources()

    -- Switch to Hangul
    for _, inputSource in ipairs(inputSources) do
        if inputSource.id == 'com.apple.keylayout.Hangul' then
            hs.keycodes.setLayout(inputSource.id)
            return
        end
    end

    -- Switch to English
    for _, inputSource in ipairs(inputSources) do
        if inputSource.id == 'com.apple.keylayout.US' then
            hs.keycodes.setLayout(inputSource.id)
            return
        end
    end
end

Hangul = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
    local flags = event:getFlags()
    local keyCode = event:getKeyCode()  -- Key pressed
    local frontApp = hs.application.frontmostApplication():name()  -- Active app

    -- Exclude specific apps
    for _, app in ipairs(excludeApps) do
        if frontApp == app then
            return false
        end
    end

    -- Right Command key pressed
    if keyCode == hs.keycodes.map["rightcmd"] then
        if flags.cmd then
            toggleHangulInput()  -- Switch Hangul
        end
        return true
    end
end)

Hangul:start()  -- Start listener
