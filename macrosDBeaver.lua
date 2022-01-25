-- Macros for DBeaver

local dbeaverOpenURL = hs.hotkey.new({'cmd','alt', 'shift', 'control'}, 'o', nil, function() 
    local et = hs.eventtap
    et.keyStroke({'cmd'}, 'c') 
    hs.application.launchOrFocus('Google Chrome')
    et.keyStroke({'cmd'}, 't')
    et.keyStroke({'cmd'}, 'l')
    et.keyStroke({'cmd'}, 'v')
    et.keyStroke({}, 'return')
end)

local dbeaverUpdateIrrelevantToTwo = hs.hotkey.new({'cmd','alt', 'shift', 'control'}, 'n', nil, function() 
    local et = hs.eventtap
    et.keyStroke({}, 'left')
    hs.timer.doAfter(0.3, function() 
        et.keyStroke({}, '2')
        et.keyStroke({}, 'return')
        et.keyStroke({}, 'right')
        et.keyStroke({}, 'down')
    end)
end)

function dbeaverFocused()
    dbeaverOpenURL:enable()
    dbeaverUpdateIrrelevantToTwo:enable()
end

function dbeaverUnfocused()
    dbeaverOpenURL:disable()
    dbeaverUpdateIrrelevantToTwo:disable()
end

hs.window.filter.new(false):setAppFilter('DBeaver')
    :subscribe(hs.window.filter.windowFocused, dbeaverFocused)
    :subscribe(hs.window.filter.windowUnfocused, dbeaverUnfocused)
