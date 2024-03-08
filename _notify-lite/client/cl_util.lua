local settings = Cfg.Data

getMinimapAnchor = function()
    local safezone = GetSafeZoneSize()
    local safezone_x = 1.0 / 20.0
    local safezone_y = 1.0 / 20.0
    local aspect_ratio = GetAspectRatio(0)
    local res_x, res_y = GetActiveScreenResolution()
    local xscale = 1.0 / res_x
    local yscale = 1.0 / res_y
    local Minimap = {}
    Minimap.width = xscale * (res_x / (4 * aspect_ratio))
    Minimap.height = yscale * (res_y / 5.674)
    Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
    Minimap.right_x = Minimap.left_x + Minimap.width
    Minimap.top_y = Minimap.bottom_y - Minimap.height
    Minimap.x = Minimap.left_x
    Minimap.y = Minimap.top_y
    Minimap.xunit = xscale
    Minimap.yunit = yscale
    return Minimap
end


CreateThread(function()
    while true do Wait(500)
        local miniMap = getMinimapAnchor()
        if not IsRadarHidden() then
            SendNUIMessage({
                action = 'Util',
                setPos = 230
            })
        else
            SendNUIMessage({
                action = 'Util',
                setPos = miniMap.top_y * 25
            })
        end
    end
end)

local function containsString(str)
    for _, v in ipairs(settings.forbiddenStrings) do
        if string.find(str, v) then
            return true
        end
    end
    return false
end

playSound = function(sound)
    PlaySoundFrontend(-1, sound['dictName'], sound['soundName'], 0, 0, 1)
end

sendMessage = function(action, type, title, msg, time, sound)
    SendNUIMessage({
        action = action,
        type = type,
        title = title,
        msg = msg,
        time = time * 1000
    })
    playSound(sound)
end

initNotify = function(type, title, msg, time)
    if containsString(msg) then
        PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', 0, 0, 1)
        initNotify(4, settings.Locales['error_Title'], settings.Locales['error_Message'], 2.5)
        return
    else
        sendMessage("sendNotify", settings.Notify.maxDisplayed, settings.Notify.types[type], title, msg, time, settings.Notify.sound)
    end
end

initAnnounce = function(type, title, msg, time)
    if containsString(msg) then
        PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', 0, 0, 1)
        initNotify(4, settings.Locales['error_Title'], settings.Locales['error_Message'], 2.5)
        return
    else
        sendMessage("sendAnnounce", settings.Announce.types[type], title, msg, time, settings.Announce.sound)
    end
end
