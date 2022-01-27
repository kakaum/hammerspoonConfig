-- Adapted from https://github.com/philc/hammerspoon-config

viModeEnabled = true

local inNormalMode = false

local normal = hs.hotkey.modal.new()
function normal:entered() inNormalMode = true end
function normal:exited() inNormalMode = false end

local inVisualMode = false
local visual = hs.hotkey.modal.new()
function visual:entered() inVisualMode = true end
function visual:exited() inVisualMode = false end

function exitAllModes()
    visual:exit()
    normal:exit()
end

function notifyModeChange(message)
    -- Show this alert in the lower edge of the screen, and make it less pronounced than my default styles.
    style = {table.unpack(hs.alert.defaultStyle)} -- Copy by value the default style table.
    -- style.atScreenEdge = 1
    style.textSize = 18
    -- style.fillColor = {white = 0.05, alpha = 1} -- Use an alpha of 1 because the alerts overlay each other.
    style.fillColor = blueFill
    style.radius = 10
    hs.alert.show(message, style, 0.5)
end

local listOfIgnoringViMode = {'HandBrake', 'Calculator', 'Screen Sharing', 'VMWare Fusion', 'Keynote', 'IntelliJ IDEA', 'MySQLWorkbench', 'Pages', 'Numbers', 'Xcode', 'Code', 'iTerm2', 'Terminal', 'Microsoft Edge', 'Google Chrome', 'KakaoTalk', 'Simulator', 'DBeaver', 'Thunderbird', 'Android Studio', 'Chrome Remote Desktop', 'Hammerspoon'}
for _, toIgnore in ipairs(listOfIgnoringViMode) do
  hs.window.filter.new(toIgnore)
  :subscribe(hs.window.filter.windowFocused, function() toInsertMode() end)
end

local listOfDefaultViMode = {'Microsoft OneNote', 'Foxit PDF Reader', 'Preview', 'Books', 'Finder', 'IINA'}
for _, defaultVim in ipairs(listOfDefaultViMode) do
  hs.window.filter.new(defaultVim)
  :subscribe(hs.window.filter.windowFocused, function() toNormalMode() end)
  -- :subscribe(hs.window.filter.windowUnfocused, function() toInsertMode() end)
end

function viModeShouldBeIgnored() 
    -- fw = hs.window.focusedWindow()
    fw = hs.window.frontmostWindow()
    if fw == nil then
      myAlert('fw is nil. Just returning true', 1)
      return true
    end
    app = fw:application()
    if app == nil then
      myAlert('app is nil. Just returning true', 1)
      return true
    end

    local  nameToBeChecked = app:title()
    for _, toIgnore in ipairs(listOfIgnoringViMode) do
      if nameToBeChecked == toIgnore then
        return true
      end
    end
    return false
end

function toggleModes()
  if (inNormalMode) then
    exitAllModes()
    notifyModeChange('Insert')
  else
    normal:enter()
    notifyModeChange('Normal')
  end
end

function toNormalMode()
  if not (inNormalMode) then
    exitAllModes()
    normal:enter()
    notifyModeChange('Normal')
  end
end
function toInsertMode()
  if inNormalMode or inVisualMode then
    exitAllModes()
    notifyModeChange('Insert')
  end
end

-- Toggle between insert and normal mode by tapping shift-escape key.
-- Escape was mapped to F20 (also see escape.lua)
enterNormal = hs.hotkey.bind({'shift'}, "F20", toNormalMode)

function doNothing() end

local ignoreInNormalMode = {
  '1','2','3','4','5','6','7','8','9','`','-','=','[',']','\\',',','.','\'',
  'c','f','m','n','q','r','s','t'
}
for _, key in ipairs(ignoreInNormalMode) do 
  normal:bind({}, key, doNothing)
end

local ignoreWithShiftInNormalMode = {
  'b','c','e','f','j','k','l','m','n','p','q','r','s','t','u','v','w','x','y','z',
  '`','1','2','3','5','6','7','8','9','0','-','=','[',']','\\',',','.','/','\''
}
for _, key in ipairs(ignoreWithShiftInNormalMode) do 
  normal:bind({'shift'}, key, doNothing)
end

function left() lib.keyStroke(false, {}, "Left") end
normal:bind({}, 'h', left, nil, left)

function right() lib.keyStroke(false, {}, "Right") end
normal:bind({}, 'l', right, nil, right)

function up() lib.keyStroke(false, {}, "Up") end
normal:bind({}, 'k', up, nil, up)

function down() lib.keyStroke(false, {}, "Down") end
normal:bind({}, 'j', down, nil, down)

-- w, e: Move to the next word.
function word() lib.keyStroke(false, {"alt"}, "Right") end
normal:bind({}, 'w', word, nil, word)
normal:bind({}, 'e', word, nil, word)

-- b: Move to the previous word.
function back() lib.keyStroke(false, {"alt"}, "Left") end
normal:bind({}, 'b', back, nil, back)

-- 0: Move to the beginning of the line
-- normal:bind({}, '0', function() lib.keyStroke(false, {"cmd"}, "Left") end)
normal:bind({}, '0', function() lib.keyStroke(false, {"ctrl"}, "a") end)

normal:bind({"shift"}, 'h', function() lib.keyStroke(false, {"cmd"}, "Left") end)

-- $: Move to the end of the line
-- normal:bind({"shift"}, '4', function() lib.keyStroke(false, {"cmd"}, "Right") end)
normal:bind({"shift"}, '4', function() lib.keyStroke(false, {"ctrl"}, "e") end)

normal:bind({"shift"}, 'l', function() lib.keyStroke(false, {"cmd"}, "Right") end)

-- g: Move to beginning of text
normal:bind({}, 'g', function() lib.keyStroke(false, {"cmd"}, "Up") end)

-- G: Move to the end of text
normal:bind({"shift"}, 'g', function() lib.keyStroke(false, {"cmd"}, "Down") end)

-- z: Center cursor
normal:bind({}, 'z', function() lib.keyStroke(false, {"ctrl"}, "L") end)

-- ctrl-f: Page down
normal:bind({"ctrl"}, "f", function() lib.keyStroke(false, {}, "pagedown") end)

-- ctrl-b: Page up
normal:bind({"ctrl"}, "b", function() lib.keyStroke(false, {}, "pageup") end)

-- d: delete character before the cursor
local function delete() lib.keyStroke(false, {}, "delete") end
normal:bind({}, 'd', delete, nil, delete)

-- x: delete character after the cursor
local function fndelete()
  lib.keyStroke(false, {}, "Right")
  lib.keyStroke(false, {}, "delete")
end
normal:bind({}, 'x', fndelete, nil, fndelete)

-- D: delete until end of line
normal:bind({"shift"}, 'D', nil, function()
    lib.keyStroke(false, {"ctrl"}, "k")
  end)

-- u: undo
normal:bind({}, 'u', function() lib.keyStroke(false, {"cmd"}, "z") end)

-- <c-r>: redo
normal:bind({"ctrl"}, 'r', function() lib.keyStroke(false, {"cmd", "shift"}, "z") end)

-- y: yank
normal:bind({}, 'y', function() lib.keyStroke(false, {"cmd"}, "c") end)

-- p: paste
normal:bind({}, 'p', function() lib.keyStroke(false, {"cmd"}, "v") end)

-- Insert

-- i: insert at cursor
normal:bind({}, 'i', function()
    normal:exit()
    notifyModeChange('Insert mode')
  end)

-- I: insert at beggining of line
normal:bind({"shift"}, 'i', function()
    lib.keyStroke(false, {"cmd"}, "Left")
    normal:exit()
    notifyModeChange('Insert mode')
  end)

-- a: append after cursor
normal:bind({}, 'a', function()
    lib.keyStroke(false, {}, "Right")
    normal:exit()
    notifyModeChange('Insert mode')
  end)

-- A: append to end of line
normal:bind({"shift"}, 'a', function()
    lib.keyStroke(false, {"cmd"}, "Right")
    normal:exit()
    notifyModeChange('Insert mode')
  end)

-- o: open new line below cursor
normal:bind({}, 'o', nil, function()
    local app = hs.application.frontmostApplication()
    if app:name() == "Finder" then
      lib.keyStroke(false, {"cmd"}, "o")
    else
      lib.keyStroke(false, {"cmd"}, "Right")
      normal:exit()
      lib.keyStroke(false, {}, "Return")
      notifyModeChange('Insert mode')
    end
  end)

-- O: open new line above cursor
normal:bind({"shift"}, 'o', nil, function()
    local app = hs.application.frontmostApplication()
    if app:name() == "Finder" then
      lib.keyStroke(false, {"cmd", "shift"}, "o")
    else
      lib.keyStroke(false, {"cmd"}, "Left")
      normal:exit()
      lib.keyStroke(false, {}, "Return")
      lib.keyStroke(false, {}, "Up")
      notifyModeChange('Insert mode')
    end
  end)

-- /: search
normal:bind({}, '/', function() 
    lib.keyStroke(false, {"cmd"}, "f") 
    toggleModes()
end)


----------------------------------------------------------------------------------------------
-- Visual mode
----------------------------------------------------------------------------------------------

-- v: enter Visual mode
normal:bind({}, 'v', function() normal:exit() visual:enter() end)
function visual:entered() notifyModeChange('Visual mode') end

-- alt-escape: exit Visual mode
visual:bind({"alt"}, 'F20', function()
    visual:exit()
    normal:enter()
    lib.keyStroke(false, {}, "Right")
    notifyModeChange('Normal mode')
  end)
  
local  ignoreInVisualMode = {
    '1','2','3','4','5','6','7','8','9','`','-','=','[',']','\\',',','.','\'',
    'a','f','i','m','n','o','q','r','s','t','u','v','z'
}
for _, key in ipairs(ignoreInVisualMode) do 
  visual:bind({}, key, doNothing)
end
  
local  ignoreWithShiftInVisualMode = {
  'a','b','c','e','f','i','j','k','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
  '`','1','2','3','5','6','7','8','9','0','-','=','[',']','\\',',','.','/','\''
}
for _, key in ipairs(ignoreWithShiftInVisualMode) do 
  visual:bind({'shift'}, key, doNothing)
end
    
-- h: move left
function vleft() lib.keyStroke(false, {"shift"}, "Left") end
visual:bind({}, 'h', vleft, nil, vleft)

-- l: move right
function vright() lib.keyStroke(false, {"shift"}, "Right") end
visual:bind({}, 'l', vright, nil, vright)

-- k: move up
function vup() lib.keyStroke(false, {"shift"}, "Up") end
visual:bind({}, 'k', vup, nil, vup)

-- j: move down
function vdown() lib.keyStroke(false, {"shift"}, "Down") end
visual:bind({}, 'j', vdown, nil, vdown)

-- w: move to next word
function word() lib.keyStroke(false, {"alt", "shift"}, "Right") end
visual:bind({}, 'w', word, nil, word)
visual:bind({}, 'e', word, nil, word)

-- b: move to previous word
function back() lib.keyStroke(false, {"alt", "shift"}, "Left") end
visual:bind({}, 'b', back, nil, back)

-- 0, H: move to beginning of line
visual:bind({}, '0', function() lib.keyStroke(false, {"cmd", "shift"}, "Left") end)

visual:bind({"shift"}, 'h', function() lib.keyStroke(false, {"cmd", "shift"}, "Left") end)

-- $, L: move to end of line
-- visual:bind({"shift"}, '4', function() lib.keyStroke(false, {"cmd", "shift"}, "Right") end)
-- visual:bind({"shift"}, 'l', function() lib.keyStroke(false, {"cmd", "shift"}, "Right") end)
visual:bind({"shift"}, '4', function() lib.keyStroke(false, {"ctrl", "shift"}, "e") end)
visual:bind({"shift"}, 'l', function() lib.keyStroke(false, {"ctrl", "shift"}, "e") end)

-- g: move to beginning of text
visual:bind({}, 'g', function() lib.keyStroke(false, {"shift", "cmd"}, "Up") end)

-- G: move to end of line
visual:bind({"shift"}, 'g', function() lib.keyStroke(false, {"shift", "cmd"}, "Down") end)

-- d, x: cut selection
local function vdelete()
  lib.keyStroke(false, {'cmd'}, 'x')
  toNormalMode()
end
visual:bind({}, 'd', vdelete)
visual:bind({}, 'x', vdelete)

-- c: cut selection and change to insert mode
local function vdeleteAndInsertMode()
  lib.keyStroke(false, {'cmd'}, 'x')
  -- hs.timer.doAfter(0.1, function()
    visual:exit()
    normal:enter()
    toInsertMode()
  -- end)
end
visual:bind({}, 'c', vdeleteAndInsertMode)

-- y: yank
visual:bind({}, 'y', function()
    lib.keyStroke(false, {"cmd"}, "c")
    hs.timer.doAfter(0.1, function()
        visual:exit()
        normal:enter()
        lib.keyStroke(false, {}, "Right")
        notifyModeChange('Normal mode')
    end)
end)

-- p: paste
visual:bind({}, 'p', function()
    lib.keyStroke(false, {"cmd"}, "v")
    visual:exit()
    normal:enter()
    lib.keyStroke(false, {}, "Right")
    notifyModeChange('Normal mode')
end)
