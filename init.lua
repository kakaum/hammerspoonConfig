--[[

Before all of these, you should remap the followings by hidutil!!!!!!
    - capslock to F18
    - escape to F20

See below (link to a personal note):
https://onedrive.live.com/view.aspx?resid=17D206403A002017%21107&id=documents&wd=target%28Tips%20-%20Mac.one%7C516F5B96-EF7E-4589-AFDF-196E5F6A0EEF%2Fhidutil%EC%9D%84%20%EC%9D%B4%EC%9A%A9%ED%95%9C%20key%20remapping%7CBC935B78-341B-7E4A-991D-B22586909469%2F%29

]]
-- Following modules should be loaded in proper order, before other modules.
lib = require("modules/lib")
require("modules/misc")

-- Use capslock key like a well known hyper key
require('modules/hyperlike')

-- Escape key should change input source to ABC and set vi mode to normal
-- Note: this re-binding of Escape disables Opt-Cmd-Esc for force quitting non-responsive application
require('modules/escape')

--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
-- Three different vi style modules. Not absolutely necessary to be exclusive to one another, but most likely will be.

-- 1. my own stupid lua
-- hjklSomeAppsMode = true
-- require('hjklSomeApps')

-- 2. vim.lua modified
viModeEnabled = true
require('modules/vim')

-- 3. VimMode spoon from https://github.com/dbalatero/VimMode.spoon
--[[
    Unfortunately can't use this spoon together with Alfred or Raycast as long as I use 'escape' to enter normal mode
]]
-- local VimMode = hs.loadSpoon('VimMode')
-- local vim = VimMode:new()
-- vim
--     :bindHotKeys({ enter = {{''}, 'F20'} })
--     :shouldDimScreenInNormalMode(false)
--     :disableForApp('Microsoft Edge')
--     :disableForApp('Code')
--     :disableForApp('iTerm')   -- shoud be iTerm2 ???
--     :disableForApp('Terminal')
--     :disableForApp('KakaoTalk')
--     :disableForApp('Simulator')
--     :disableForApp('DBeaver')
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------

-- Some more modules
require('modules/displayWatcher')
require('modules/kakaotalk')
require('modules/showInputSource')

-- Load more macros
require('modules/macrosDBeaver')
require('modules/macrosThunderbird')

-- Just say I'm here to serve you again
hs.alert.show("Config loaded", 0.5)
