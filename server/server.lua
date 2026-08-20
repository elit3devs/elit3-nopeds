RegisterNetEvent("elit3-nopeds:syncClear", function()
    TriggerClientEvent("elit3-nopeds:doClear", -1)
end)

AddEventHandler("playerJoining", function()
    TriggerClientEvent("elit3-nopeds:doClear", source)
end)
