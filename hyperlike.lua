-- A global variable for the Hyper-like Mode
capslock_modal = hs.hotkey.modal.new({}, nil)

-- Enter Hyper-like Mode when capslock is pressed
pressedF18 = function()
    capslock_modal.triggered = false 
    capslock_modal:enter()
end

-- Leave Hyper-like Mode when capslock is released,
--   send ESCAPE if no other keys are pressed until capslock is released.
releasedF18 = function()
    capslock_modal:exit()
    if not capslock_modal.triggered then
        lib.keyStroke(false, {}, 'ESCAPE')
        toABC()

        if viModeEnabled and (not viModeShouldBeIgnored()) then
            toNormalMode()
        end
        disableCapslock()
    end
end

-- Bind the Hyper-like key
hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

-- Generate global (original?) hyper keys. E.g. capslock+a generates {'cmd','alt','shift','ctrl'}+a
-- Do need these {'cmd','alt','shift','ctrl'} chord generation because some apps like Keyboard Maestro doesn't accept F18 as modifier, 
-- meaning that you can't set hotkeys like F18+n (as opposed to {'cmd','alt','shift','ctrl'}+n) in there.
-- Also note that some keys (e.g. hjkl, return and a few others) are intentionally excluded here.
local hyperlikeBindings = {'a','b','d','e','m','n','o','p','q','r','s','t','v','x','w','z',';',"'",'`','\\'}
for _, key in ipairs(hyperlikeBindings) do 
    capslock_modal:bind({}, key, nil, lib.keypress(true, {'shift','ctrl','alt','cmd'}, key))
end

-- Bind Capslock + hjkl as the arrows 
capslock_modal:bind({}, 'h', lib.keypress(true, 'left'), nil, lib.keypress(true, 'left'))
capslock_modal:bind({'shift'}, 'h', lib.keypress(true, {'shift'},'left'), nil, lib.keypress(true, {'shift'},'left'))
capslock_modal:bind({}, 'j', lib.keypress(true, 'down'), nil, lib.keypress(true, 'down'))
capslock_modal:bind({'shift'}, 'j', lib.keypress(true, {'shift'},'down'), nil, lib.keypress(true, {'shift'},'down'))
capslock_modal:bind({}, 'k', lib.keypress(true, 'up'), nil, lib.keypress(true, 'up'))
capslock_modal:bind({'shift'}, 'k', lib.keypress(true, {'shift'},'up'), nil, lib.keypress(true, {'shift'},'up'))
capslock_modal:bind({}, 'l', lib.keypress(true, 'right'), nil, lib.keypress(true, 'right'))
capslock_modal:bind({'shift'}, 'l', lib.keypress(true, {'shift'},'right'), nil, lib.keypress(true, {'shift'},'right'))

-- -- Press `Capslock+r`, get the Hammerspoon console.
-- capslock_modal:bind({}, 'r', function()
--     hs.console.hswindow():focus()
--     capslock_modal.triggered = true
-- end, nil, nil)

-- -- Press `Capslock+⇧+r`, reload Hammerspoon configuration.
-- capslock_modal:bind({'shift'}, 'r', function()
--     hs.reload()
-- end, nil, nil)

-- capslock+shift+i for getting focused window name
capslock_modal:bind({'shift'}, 'i', function()
    myAlert(hs.window.focusedWindow():application():title(), 2)
end, nil, nil)

-- -- capslock+p for hs.tabs.enableForApp
-- capslock_modal:bind({}, 'p', function()
--     appl = hs.application.frontmostApplication()
--     hs.tabs.enableForApp(appl)
-- end)

-- Go to prev/next tab
capslock_modal:bind({}, 'u', function() hs.eventtap.keyStroke({'cmd','shift'}, '[') capslock_modal.triggered = true end, nil)
capslock_modal:bind({}, 'i', function() hs.eventtap.keyStroke({'cmd','shift'}, ']') capslock_modal.triggered = true end, nil)

-- Xcode specific
capslock_modal:bind({}, 'f', lib.keypress(true, {'cmd','alt'}, 'left'), nil, lib.keypress(true, {'cmd','alt'}, 'left'))
capslock_modal:bind({}, 'g', lib.keypress(true, {'cmd','alt'}, 'right'), nil, lib.keypress(true, {'cmd','alt'}, 'right'))

capslock_modal:bind({}, 'delete', lib.keypress(true, {'cmd','control'}, 'left'), nil, lib.keypress(true, {'cmd','control'}, 'left'))
capslock_modal:bind({}, 'y', lib.keypress(true, {'cmd','shift'}, 'a'), nil, lib.keypress(true, {'cmd','shift'}, 'a'))
capslock_modal:bind({}, '.', lib.keypress(true, {'cmd','shift','ctrl'}, '/'), nil, lib.keypress(true, {'cmd','shift','ctrl'}, '/'))
capslock_modal:bind({}, '[', nil, function() hs.eventtap.keyStroke({"cmd","option","control"}, '[') capslock_modal.triggered = true end)
capslock_modal:bind({}, ']', nil, function() hs.eventtap.keyStroke({"cmd","option","control"}, ']') capslock_modal.triggered = true end)
capslock_modal:bind({}, '/', nil, function() hs.eventtap.keyStroke({"cmd","option","control"}, '/') capslock_modal.triggered = true end)

-- It is really hard to press function keys in Micorsoft Sculpt keyboard...
-- 1/2/../0/-/= for F1/F2/../F10/F11/F12
capslock_modal:bind({}, '1', lib.keypress(true, 'f1'), nil, lib.keypress(true, 'f1'))
capslock_modal:bind({}, '2', lib.keypress(true, 'f2'), nil, lib.keypress(true, 'f2'))
capslock_modal:bind({}, '3', lib.keypress(true, 'f3'), nil, lib.keypress(true, 'f3'))
capslock_modal:bind({}, '4', lib.keypress(true, 'f4'), nil, lib.keypress(true, 'f4'))
capslock_modal:bind({}, '5', lib.keypress(true, 'f5'), nil, lib.keypress(true, 'f5'))
capslock_modal:bind({}, '6', lib.keypress(true, 'f6'), nil, lib.keypress(true, 'f6'))
capslock_modal:bind({}, '7', lib.keypress(true, 'f7'), nil, lib.keypress(true, 'f7'))
capslock_modal:bind({}, '8', lib.keypress(true, 'f8'), nil, lib.keypress(true, 'f8'))
capslock_modal:bind({}, '9', lib.keypress(true, 'f9'), nil, lib.keypress(true, 'f9'))
capslock_modal:bind({}, '0', lib.keypress(true, 'f10'), nil, lib.keypress(true, 'f10'))
capslock_modal:bind({}, '-', lib.keypress(true, 'f11'), nil, lib.keypress(true, 'f11'))
capslock_modal:bind({}, '=', lib.keypress(true, 'f12'), nil, lib.keypress(true, 'f12'))

-- Mouse control by keyboard
capslock_modal:bind({'ctrl'}, '\'', nil, doubleClickCurr)
capslock_modal:bind({'ctrl'}, 'return', nil, leftClickCurr)
capslock_modal:bind({'ctrl'}, '\\', nil, rightClickCurr)
capslock_modal:bind({'ctrl'}, 'h', movePointerLeft, nil, movePointerLeft)
capslock_modal:bind({'ctrl'}, 'j', movePointerDown, nil, movePointerDown)
capslock_modal:bind({'ctrl'}, 'k', movePointerUp, nil, movePointerUp)
capslock_modal:bind({'ctrl'}, 'l', movePointerRight, nil, movePointerRight)
capslock_modal:bind({'ctrl', 'shift'}, 'h', movePointerLeftFast, nil, movePointerLeftFast)
capslock_modal:bind({'ctrl', 'shift'}, 'j', movePointerDownFast, nil, movePointerDownFast)
capslock_modal:bind({'ctrl', 'shift'}, 'k', movePointerUpFast, nil, movePointerUpFast)
capslock_modal:bind({'ctrl', 'shift'}, 'l', movePointerRightFast, nil, movePointerRightFast)


--[[ 2021/12/10 caps-left/right/up/down will NOT change window size any longer
capslock_modal:bind({}, 'left', function() moveToScreen(0) moveLeftHalf() capslock_modal.triggered = true end)
capslock_modal:bind({}, 'right', function() moveToScreen(0) moveRightHalf() capslock_modal.triggered = true end)
capslock_modal:bind({}, 'up', function() moveToScreen(0) moveCenterBig() capslock_modal.triggered = true end)
]]--
capslock_modal:bind({'cmd'}, 'left', function() moveToScreen(0) moveLeftHalf() capslock_modal.triggered = true end)
capslock_modal:bind({'cmd'}, 'right', function() moveToScreen(0) moveRightHalf() capslock_modal.triggered = true end)
capslock_modal:bind({}, 'left', moveLeftmost, nil, moveLeftmost)
capslock_modal:bind({}, 'right', moveRightmost, nil, moveRightmost)
capslock_modal:bind({}, 'up', moveTopmost, nil, moveTopmost)
capslock_modal:bind({}, 'down', moveBottommost, nil, moveBottommost)

-- capslock_modal:bind({}, 'c', function() moveToScreen(0) hs.window.focusedWindow():centerOnScreen() capslock_modal.triggered = true end)
capslock_modal:bind({}, 'c', function() moveToScreen(0) moveCenter() capslock_modal.triggered = true end)
capslock_modal:bind({}, 'b', function() moveToScreen(0) moveCenterBig() capslock_modal.triggered = true end)
capslock_modal:bind({}, 'm', function() moveToScreen(0) maximize() capslock_modal.triggered = true end)

capslock_modal:bind({'cmd'}, 'h', moveLeft, nil, moveLeft)
capslock_modal:bind({'cmd'}, 'l', moveRight, nil, moveRight)
capslock_modal:bind({'cmd'}, 'j', moveDown, nil, moveDown)
capslock_modal:bind({'cmd'}, 'k', moveUp, nil, moveUp)
capslock_modal:bind({'alt'}, 'h', decreaseWidth, nil, decreaseWidth)
capslock_modal:bind({'alt'}, 'l', increaseWidth, nil, increaseWidth)
capslock_modal:bind({'alt'}, 'j', increaseHeight, nil, increaseHeight)
capslock_modal:bind({'alt'}, 'k', decreaseHeight, nil, decreaseHeight)