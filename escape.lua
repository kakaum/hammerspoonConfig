-- Escape(should be remapped to F20 by "ln -s ~/bin/kakaumRemap.esc ~/bin/kakaumRemap) will send Escape and call toABC() for better vi experience
hs.hotkey.bind({}, 'F20', function()
    lib.keyStroke(false, {}, 'escape')
    toABC()
    if viModeEnabled and (not viModeShouldBeIgnored()) then
        toNormalMode()
    end
    disableCapslock()
end)
