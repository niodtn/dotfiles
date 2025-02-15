local excludeApps = {
    "Moonlight"  -- Exclude Moonlight app
}
local inputEnglish = "com.apple.keylayout.ABC"
local inputKorean = "com.apple.inputmethod.Korean.2SetKorean"

-- Switch between Hangul and English
function toggleHangulInput()
    local inputSource = hs.keycodes.currentSourceID()

    -- Switch to Hangul
    if not (inputSource == inputEnglish) then
        hs.keycodes.currentSourceID(inputKorean)
    end

    -- Switch to English
    if not (inputSource == inputKorean) then
        hs.keycodes.currentSourceID(inputEnglish)
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
