-- Notify 
RegisterNetEvent("notify")
AddEventHandler("notify", function(type, title, msg, time)
    initNotify(type, title, msg, time*1000)
end)

-- Announce
RegisterNetEvent("notify:announce")
AddEventHandler("notify:announce", function(type, title, msg, time)
    initAnnounce(type, title, msg, time*1000)
end)