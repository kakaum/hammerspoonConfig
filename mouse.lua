mouse = require('hs.mouse')

doubleClickCurr = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()

    local clickState = hs.eventtap.event.properties.mouseEventClickState
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types["leftMouseDown"], currentPoint):setProperty(clickState, 1):post()
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types["leftMouseUp"], currentPoint):setProperty(clickState, 1):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types["leftMouseDown"], currentPoint):setProperty(clickState, 2):post()
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types["leftMouseUp"], currentPoint):setProperty(clickState, 2):post()
end

leftClickCurr = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()
    -- hs.eventtap.event.newMouseEvent(hs.eventtap.event.types["leftMouseDown"], currentPoint):post()
    hs.eventtap.leftClick(currentPoint)
end

rightClickCurr = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()
    -- hs.eventtap.event.newMouseEvent(hs.eventtap.event.types["rightMouseDown"], currentPoint):post()
    hs.eventtap.rightClick(currentPoint)
end

movePointerLeft = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()
    mouse.setRelativePosition({x = currentPoint.x - 5, y = currentPoint.y})
end

movePointerUp = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()
    mouse.setRelativePosition({x = currentPoint.x, y = currentPoint.y - 5})
end

movePointerDown = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()
    mouse.setRelativePosition({x = currentPoint.x, y = currentPoint.y + 5})
end

movePointerRight = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()
    mouse.setRelativePosition({x = currentPoint.x + 5, y = currentPoint.y})
end

movePointerLeftFast = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()
    mouse.setRelativePosition({x = currentPoint.x - 30, y = currentPoint.y})
end

movePointerUpFast = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()
    mouse.setRelativePosition({x = currentPoint.x, y = currentPoint.y - 30})
end

movePointerDownFast = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()
    mouse.setRelativePosition({x = currentPoint.x, y = currentPoint.y + 30})
end

movePointerRightFast = function ()
    capslock_modal.triggered = true 
    local currentPoint = mouse.getRelativePosition()
    mouse.setRelativePosition({x = currentPoint.x + 30, y = currentPoint.y})
end
