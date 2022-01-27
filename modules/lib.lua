-- Adapted from https://github.com/philc/hammerspoon-config

local M = {}

-- Emits a keystroke like hs.eventtap.keyStroke, except that there is no delay between when this function is
-- called and when the keystroke is omitted. The default implementation of hs.eventtap.keyStroke makes
-- keystrokes emitted by the keyStroke function laggy (intentionally so). See:
-- https://github.com/Hammerspoon/hammerspoon/issues/1011#issuecomment-261114434
function M.keyStroke(with_capslock_modal, modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
  if with_capslock_modal then
    capslock_modal.triggered = true
  end
end

-- A function which, when invoked, triggers a keystroke.
-- Don't use this to emit a keystroke. Instead, use M.keyStroke() above.
-- hjklSomeApps.lua does use this function.
function M.keypress(with_capslock_modal, modifiers, character)
  if character == nil then
    character = modifiers
    modifiers = nil
  end
  return function() M.keyStroke(with_capslock_modal, modifiers, character) end
end

return M
