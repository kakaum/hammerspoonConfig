---------------------
-- Window positioning
---------------------
local moveOffset = 15
local resizeBy = 20

function moveLeftHalf()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function moveRightHalf()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function moveCenterBig()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  local newWidth = max.w / 1.6
  f.x = max.x + ((max.w - newWidth)/2)
  f.y = max.y
  f.w = newWidth
  f.h = max.h
  win:setFrame(f)
end

function moveCenter()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  -- myAlert('f.w: ' .. f.w)
  f.x = max.x + ((max.w - f.w)/2)
  f.y = max.y + ((max.h - f.h)/2)
  win:setFrame(f)
end

function maximize()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end

function moveToScreen(screenPos)
  window = hs.window.focusedWindow()
  screen = hs.screen.find({x=screenPos, y=0})
  window:moveToScreen(screen)
end

-- Toggle the window width to take up 1/3 of the screen vs. 2/3. This is useful for ultrawide monitors.
function toggleThirds()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  if f.w >= max.w / 2 then
    f.w = max.w / 3
  else
    f.w = max.w / 3 * 2
  end
  if f.x ~= 0 then
    f.x = max.x + (max.w - f.w)
  end
  win:setFrame(f)
end

function moveHorizontalByOffset(offset)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = f.x + offset
  win:setFrame(f)
end

function moveLeft()
  moveToScreen(0)
  moveHorizontalByOffset(-moveOffset)
  capslock_modal.triggered = true
end

function moveRight()
  moveToScreen(0)
  moveHorizontalByOffset(moveOffset)
  capslock_modal.triggered = true
end

function moveVerticalByOffset(offset)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.y = f.y + offset
  win:setFrame(f)
end

function moveUp()
  moveToScreen(0)
  moveVerticalByOffset(-moveOffset)
  capslock_modal.triggered = true
end

function moveDown()
  moveToScreen(0)
  moveVerticalByOffset(moveOffset)
  capslock_modal.triggered = true
end

function changeWidth(by)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.w = f.w + by
  win:setFrame(f)
end

function increaseWidth() 
  moveToScreen(0)
  changeWidth(resizeBy)
  capslock_modal.triggered = true
end

function decreaseWidth() 
  moveToScreen(0)
  changeWidth(-resizeBy)
  capslock_modal.triggered = true
end

function changeHeight(by)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.h = f.h + by
  win:setFrame(f)
end

function increaseHeight() 
  moveToScreen(0)
  changeHeight(resizeBy)
  capslock_modal.triggered = true
end

function decreaseHeight() 
  moveToScreen(0)
  changeHeight(-resizeBy)
  capslock_modal.triggered = true
end

function moveLeftmost()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = 0
  win:setFrame(f)
  capslock_modal.triggered = true
end

function moveRightmost()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.w - f.w
  win:setFrame(f)
  capslock_modal.triggered = true
end

function moveTopmost()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.y = 0
  win:setFrame(f)
  capslock_modal.triggered = true
end

function moveBottommost()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  -- local max = win:screen():frame()
  local max = win:screen():fullFrame()
  f.y = max.h - f.h
  win:setFrame(f)
  capslock_modal.triggered = true
end
