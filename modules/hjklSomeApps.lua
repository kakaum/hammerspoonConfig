-- hjkl for some apps

appsToEnableHJKL = {
    'Books',
    'Preview',
    'IINA',
    'Nimble Commander',
    'ForkLift',
    'Commander One PRO'
}

-- check if frontmost app is one of appsToEnableHJKL
function isHjklAppFocused()
    for k, v in pairs(appsToEnableHJKL) do
        if v == hs.application.frontmostApplication():title() then
            return true
        end
    end
    return false
end

-- Capslock+space toggles hjkl for some apps
capslock_modal:bind({}, 'space', 
    function() 
        if hjklForSomeAppActivated then
            hs.alert.show('Deactivating hjkl', 0.5)
            hjklForSomeAppActivated = false
            if isHjklAppFocused() then
                hjklAppUnfocused()
            end
        else
            hs.alert.show('Activating hjkl for some apps', 0.5)
            hjklForSomeAppActivated = true
            if isHjklAppFocused() then
                hjklAppFocused()
            end
        end

        capslock_modal.triggered = true 
    end, nil, nil)

hjklForSomeAppActivated = false

local left = hs.hotkey.new({}, 'h', lib.keypress(false, 'left'), nil, lib.keypress(false, 'left'))
local down = hs.hotkey.new({}, 'j', lib.keypress(false, 'down'), nil, lib.keypress(false, 'down'))
local up = hs.hotkey.new({}, 'k', lib.keypress(false, 'up'), nil, lib.keypress(false, 'up'))
local right = hs.hotkey.new({}, 'l', lib.keypress(false, 'right'), nil, lib.keypress(false, 'right'))
local pagedown = hs.hotkey.new({'ctrl'}, 'f', lib.keypress(false, 'pagedown'), nil, lib.keypress(false, 'pagedown'))
local pageup = hs.hotkey.new({'ctrl'}, 'b', lib.keypress(false, 'pageup'), nil, lib.keypress(false, 'pageup'))
local pagedown2 = hs.hotkey.new({'shift'}, 'j', lib.keypress(false, 'pagedown'), nil, lib.keypress(false, 'pagedown'))
local pageup2 = hs.hotkey.new({'shift'}, 'k', lib.keypress(false, 'pageup'), nil, lib.keypress(false, 'pageup'))

local savedAppName = ''

-- called when the apps in appsToEnableHJKL gets focused
function hjklAppFocused()
    savedAppName = hs.application.frontmostApplication():title()
    if hjklForSomeAppActivated then
        myAlert('Entering ' .. savedAppName, 1)
        left:enable()
        down:enable()
        up:enable()
        right:enable()
        pagedown:enable()
        pageup:enable()
        pagedown2:enable()
        pageup2:enable()
    end
end

-- called when the apps in appsToEnableHJKL gets unfocused
-- also called manually sometimes (e.g. somewhere in init.lua)
function hjklAppUnfocused()
    if hjklForSomeAppActivated == true and hjklAppUnfocusedCalledManually == false then
        myAlert('Leaving ' .. savedAppName, 1)
    end
    hjklAppUnfocusedCalledManually = false
    left:disable()
    down:disable()
    up:disable()
    right:disable()
    pagedown:disable()
    pageup:disable()
    pagedown2:disable()
    pageup2:disable()
end

for k, v in pairs(appsToEnableHJKL) do
    hs.window.filter.new(false):setAppFilter(v)
    :subscribe(hs.window.filter.windowFocused, hjklAppFocused)
    :subscribe(hs.window.filter.windowUnfocused, hjklAppUnfocused)
end
