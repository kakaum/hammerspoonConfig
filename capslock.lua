-- Enable/disable uppercase

function enableCapslock()
    if not hs.hid.capslock.get() then
    --   hs.alert.closeAll(0)
        myAlert('↑ CAPS ON', 0.5, purpleFill)
    end
    hs.hid.capslock.set(true)

    -- if capslock is enabled and screen lock is activated, then you may not be able to enter correct password FOR GOOD!!!
    -- let's use a timer to avoid this. 
    -- capslock mode will last for capslockDurableTime seconds only.
    if not capslockTimer:running() then
        capslockTimer:start()
        -- myAlert('capslock timer started', 1)
    end
end

function disableCapslock()
    if hs.hid.capslock.get() then
    --   hs.alert.closeAll(0)
        myAlert('↓ caps off', 1, purpleFill)
    end
    hs.hid.capslock.set(false)
    if capslockTimer:running() then
        capslockTimer:stop()
        -- myAlert('capslock timer stopped', 1)
    end
end

function toggleCapslock()
    if hs.hid.capslock.get() then
        disableCapslock()
    else
        enableCapslock()
    end
    return
end
  
local capslockDurableTime = 60
capslockTimer = hs.timer.new(capslockDurableTime, disableCapslock)