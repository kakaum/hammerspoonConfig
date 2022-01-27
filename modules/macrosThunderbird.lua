-- Macros for Thunderbird
local thunderbirdSaveSelected = hs.hotkey.new({'cmd', 'alt', 'shift', 'control'}, 's', nil, function()
    capslock_modal:exit()
    local et = hs.eventtap
    local dirName = '~/Downloads/JS/' .. os.date('%Y-%m-%d')
    hs.fs.mkdir(dirName)
    et.keyStroke({'cmd'}, 's')
    local timer = require 'hs.timer'
    local initialDelay = 0.2
    local interval = 0.2
    timer.doAfter(initialDelay, function()
        et.keyStroke({'cmd', 'shift'}, 'g')
        timer.doAfter(interval, function()
            et.keyStrokes(dirName)
            timer.doAfter(interval, function()
                et.keyStroke({}, 'return')
                timer.doAfter(interval, function()
                    et.keyStroke({}, 'return')
                    timer.doAfter(interval, function()
                        et.keyStroke({}, 'm')
                    end)
                end)
            end)
        end)
    end)
end)

function thunderbirdFocused()
    thunderbirdSaveSelected:enable()
end

function thunderbirdUnfocused()
    thunderbirdSaveSelected:disable()
end

hs.window.filter.new(false):setAppFilter('Thunderbird')
    :subscribe(hs.window.filter.windowFocused, thunderbirdFocused)
    :subscribe(hs.window.filter.windowUnfocused, thunderbirdUnfocused)
