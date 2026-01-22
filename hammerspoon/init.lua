-- Apps that will not use this input source switching
local excludeApps = {
    "Moonlight"  -- Exclude Moonlight app
}

-- Input source IDs
local inputEnglish = "com.apple.keylayout.ABC"
local inputKorean = "com.apple.inputmethod.Korean.2SetKorean"

-- State tracking variables
local rightCmdTimer = nil
local longPressThreshold = 0.2  -- Time in seconds before allowing key combinations
local isLongPress = false
local rightCmdDown = false  -- Track if right command key is pressed

-- Switch between Korean and English input
function toggleHangulInput()
    local inputSource = hs.keycodes.currentSourceID()

    if inputSource == inputKorean then
        hs.keycodes.currentSourceID(inputEnglish)
    else
        hs.keycodes.currentSourceID(inputKorean)
    end
end

-- First event watcher: Handle right command key press/release
Hangul = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
    local flags = event:getFlags()
    local keyCode = event:getKeyCode()
    local frontApp = hs.application.frontmostApplication():name()

    -- Skip for excluded apps
    for _, app in ipairs(excludeApps) do
        if frontApp == app then
            return false
        end
    end

    -- Handle right command key events
    if keyCode == hs.keycodes.map["rightcmd"] then
        if flags.cmd then
            -- When right command is pressed
            rightCmdDown = true
            isLongPress = false
            rightCmdTimer = hs.timer.doAfter(longPressThreshold, function()
                isLongPress = true
            end)
        else
            -- When right command is released
            if rightCmdDown and not isLongPress then
                toggleHangulInput()
            end
            rightCmdDown = false
            if rightCmdTimer then
                rightCmdTimer:stop()
                rightCmdTimer = nil
            end
        end
    end
    return false
end)

-- Second event watcher: Block key combinations until long press
KeyHandler = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
    local flags = event:getFlags()

    -- Block key combinations during short press
    if rightCmdDown and not isLongPress then
        return true
    end
    return false
end)

-- Start both event watchers
Hangul:start()
KeyHandler:start()
