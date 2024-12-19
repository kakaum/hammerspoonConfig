blueFill = {alpha = 1, red = 0.043, green = 0.211, blue = 0.773}
purpleFill = {alpha = 1, red = 0.290, green = 0.047, blue = 0.403}

-- Make the alerts look nicer.
hs.alert.defaultStyle.strokeColor = {white = 1, alpha = 0}
-- hs.alert.defaultStyle.fillColor = {alpha = 1, red = 0.043, green = 0.211, blue = 0.773}
hs.alert.defaultStyle.radius = 10
hs.alert.defaultStyle.textSize = 20

function myAlert(message, seconds, myFillColor, atScreenEdge)
    -- Show this alert in the lower edge of the screen, and make it less pronounced than my default styles.
    style = {table.unpack(hs.alert.defaultStyle)} -- Copy by value the default style table.
    style.textSize = 15
    if myFillColor == nil then
        style.fillColor = blueFill
    else
        style.fillColor = myFillColor
    end
    style.radius = 10
    if atScreenEdge == nil then
        style.atScreenEdge = 0
    else
        style.atScreenEdge = atScreenEdge
    end
    hs.alert.show(message, style, seconds)
end

-- Input source to ABC
local inputSourceEnglish = 'ABC'
function toABC()
    if hs.keycodes.currentLayout() ~= inputSourceEnglish then
        hs.alert.show(inputSourceEnglish, 0.5)
    end
    hs.keycodes.setLayout(inputSourceEnglish)
end

-- Input source to 2-Set Korean
local inputSourceKorean = '2-Set Korean'
function toKorean()
    if hs.keycodes.currentMethod() ~= inputSourceKorean then
        hs.alert.show(inputSourceKorean, 0.5)
    end
    hs.keycodes.setMethod(inputSourceKorean)
end

-- cmd+escape for window hints. Assuming we already mapped Escape to F20
hs.hints.style = "vimperator"
hs.hotkey.bind({'cmd'}, 'F20', hs.hints.windowHints)

-- Change to insert mode and toggle Alfred. In Alfred settings, Ctrl+Option+Command+Space is set to bring Alfred up.
hs.hotkey.bind({'alt'}, 'space', nil, function()
    if viModeEnabled then
        exitAllModes()
        notifyModeChange('Insert mode')
    elseif hjklSomeAppsMode then
        hjklAppUnfocusedCalledManually = true
        hjklAppUnfocused()
    end
    lib.keyStroke(false, {'ctrl','alt','cmd'}, 'space')
end)

-- Change to insert mode and toggle Raycast
hs.hotkey.bind({'cmd'}, 'space', nil, function()
    if viModeEnabled then
        exitAllModes()
        notifyModeChange('Insert mode')
    elseif hjklSomeAppsMode then
        hjklAppUnfocusedCalledManually = true
        hjklAppUnfocused()
    end
    toABC()
    lib.keyStroke(false, {'cmd','shift'}, 'space')
end)

-- Press Cmd+Q twice to quit
local quitModal = hs.hotkey.modal.new('cmd','q')
local doQuitExecuted = false
function quitModal:entered()
    hs.timer.doAfter(0.5, function() 
        if not doQuitExecuted then
            hs.alert.show("Press Cmd+Q again to quit", 1)
        else 
            doQuitExecuted = false
        end
        quitModal:exit() 
    end)
end
function doQuit()
    local res = hs.application.frontmostApplication():selectMenuItem("^Quit.*$")
    doQuitExecuted = true
    quitModal:exit()
end
quitModal:bind('cmd', 'q', doQuit)
quitModal:bind('', 'escape', function() quitModal:exit() end)

-- Automatically reload config when any .lua in ~/.hammerspoon changes
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

--[[ shift+space for kor/eng change
     전역 네임스페이스를 더럽히고 싶지 않기 때문에 do - end로 스코프를 지정했습니다.
     Adapted from https://johngrib.github.io/wiki/hammerspoon-tutorial-03/
]]

--[[
2024-12-19 아래의 input source changer를 쓸 경우 Mail 앱에서 한글이 "나나나" 대신에 "ㄴㅏㄴㅏㄴㅏ"로 잘못되는 경우가 발생한다. 일단 막는다.

do  -- input source changer
    local inputSource = {
        english = "com.apple.keylayout.ABC",
        korean = "com.apple.inputmethod.Korean.2SetKorean",
    }

    local changeInput = function()
        local current = hs.keycodes.currentSourceID()
        local nextInput = nil
        if current == inputSource.english then
            -- nextInput = inputSource.korean
            toKorean()
        else
            -- nextInput = inputSource.english
            toABC()
        end
        -- hs.keycodes.currentSourceID(nextInput)
    end

    hs.hotkey.bind({'shift'}, 'space', changeInput)
end
]]