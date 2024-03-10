local settings = Cfg.Data

-- Function to trigger the notify by type
function triggerMsg(source, ntype, title, msg, time)
    if ntype == 'notify' then
        TriggerClientEvent('notify', source, type, title, msg, time)
    elseif ntype == 'announce' then
        TriggerClientEvent('notify:announce', source, type, title, msg, time)
    else
        TriggerClientEvent('notify', source, 4, 'Error', 'The specified trigger is invalid', 2.5)
    end
end

if settings.Framework['type'] == 'ESX' then
	TriggerEvent(settings.Framework['sharedObj'], function(obj) Framework = obj end)

    RegisterCommand(settings.Announce.cmdName, function(source, args, rawCommand)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer ~= nil and xPlayer.getGroup() ~= nil then
            local hasPermission = false
            for k, v in pairs(settings.Announce.hasPerms) do
                if xPlayer.getGroup() == v then
                    hasPermission = true
                    break
                end
            end
            if hasPermission then
                local msg = table.concat(args, ' ')
                if msg == '' then return end
                triggerMsg(-1, 'announce', settings.Announce.type, settings.Locales['announce_Title'], msg, settings.Announce.time)
            else
                triggerMsg(source, 'notify', 4, settings.Locales['announce_errorTitle'], settings.Locales['announce_noPerms'], 2.5)
            end
        else
            triggerMsg(source, 'notify', 4, settings.Locales['announce_errorTitle'], settings.Locales['announce_playerData'], 2.5)
        end
    end, false)

elseif settings.Framework['type'] == "QBCore" then
    Framework = exports[settings.Framework['coreName']]:GetCoreObject()

    -- Announcement Command
    Framework.Commands.Add(settings.Announce.cmdName, settings.Locales['announce_Description'], {}, false, function(source, args)
        local player = Framework.Functions.GetPlayer(source)
        if player ~= nil and player.PlayerData ~= nil and player.PlayerData.group ~= nil then
            local hasPermission = false
            for _, group in pairs(settings.Announce.hasPerms) do
                if player.PlayerData.group == group then
                    hasPermission = true
                    break
                end
            end
            if hasPermission then
                local msg = table.concat(args, ' ')
                if msg == '' then return end
                triggerMsg(-1, 'announce', settings.Announce.type, settings.Locales['announce_Title'], msg, settings.Announce.time)
            else
                triggerMsg(source, 'notify', 4, settings.Locales['announce_errorTitle'], settings.Locales['announce_noPerms'], 2.5)
            end
        else
            triggerMsg(source, 'notify', 4, settings.Locales['announce_errorTitle'], settings.Locales['announce_playerData'], 2.5)
        end
    end)
end
