-- Adapted from https://johngrib.github.io/wiki/hammerspoon-inputsource-aurora/

local boxes = {}
local inputEnglish = "com.apple.keylayout.ABC"
local box_height = 23
local box_width = 23
local box_alpha = 0.35
local GREEN = hs.drawing.color.osx_green

-- 입력소스 변경 이벤트에 이벤트 리스너를 달아준다
hs.keycodes.inputSourceChanged(function()
    disable_show()
    if hs.keycodes.currentSourceID() ~= inputEnglish then
        enable_show()
    end
end)

function enable_show()
    reset_boxes()
    hs.fnutils.each(hs.screen.allScreens(), function(scr)
        local frame = scr:fullFrame()

        local boxTop = newBox()
        draw_rectangle(boxTop, frame.x, frame.y, frame.w, box_height, GREEN)
        table.insert(boxes, boxTop)

        local boxBottom = newBox()
        draw_rectangle(boxBottom, frame.x, frame.y + frame.h - box_height, frame.w, box_height, GREEN)
        table.insert(boxes, boxBottom)

        local boxLeft = newBox()
        draw_rectangle(boxLeft, frame.x, frame.y + box_height, box_width, frame.h - (2*box_height), GREEN)
        table.insert(boxes, boxLeft)

        local boxRight = newBox()
        draw_rectangle(boxRight, frame.x + frame.w - box_width, frame.y + box_height, box_width, frame.h - (2*box_height), GREEN)
        table.insert(boxes, boxRight)
    end)
end

function disable_show()
    hs.fnutils.each(boxes, function(box)
        if box ~= nil then
            box:delete()
        end
    end)
    reset_boxes()
end

function newBox()
    return hs.drawing.rectangle(hs.geometry.rect(0,0,0,0))
end

function reset_boxes()
    boxes = {}
end

function draw_rectangle(target_draw, x, y, width, height, fill_color)
  -- 그릴 영역 크기를 잡는다
  target_draw:setSize(hs.geometry.rect(x, y, width, height))
  -- 그릴 영역의 위치를 잡는다
  target_draw:setTopLeft(hs.geometry.point(x, y))

  target_draw:setFillColor(fill_color)
  target_draw:setFill(true)
  target_draw:setAlpha(box_alpha)
  target_draw:setLevel(hs.drawing.windowLevels.overlay)
  target_draw:setStroke(false)
  target_draw:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
  target_draw:show()
end