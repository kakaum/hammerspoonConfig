-- Watch if display is awaken from sleep, and then run remapKeys. 

function displayWatch(eventType)
	if (eventType == hs.caffeinate.watcher.screensDidWake) then
		hs.execute("/usr/bin/open ~/bin/remapKeysApp.app")
		myAlert('remapKeysApp.app', 5, purpleFill)
	end
end

displayWatcher = hs.caffeinate.watcher.new(displayWatch)
displayWatcher:start()