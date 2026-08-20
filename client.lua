local serviceModels = {
    [GetHashKey("s_m_y_cop_01")] = true,
    [GetHashKey("s_f_y_cop_01")] = true,
    [GetHashKey("s_m_y_sheriff_01")] = true,
    [GetHashKey("s_f_y_sheriff_01")] = true,
    [GetHashKey("s_m_y_ranger_01")] = true,
    [GetHashKey("s_f_y_ranger_01")] = true,
    [GetHashKey("s_m_y_securo")] = true,
    [GetHashKey("s_m_m_prisguard_01")] = true,
    [GetHashKey("s_m_y_fireman_01")] = true,
    [GetHashKey("s_m_m_paramedic_01")] = true,
    [GetHashKey("s_m_m_doctor_01")] = true,
    [GetHashKey("s_m_m_marine_01")] = true,
    [GetHashKey("s_m_m_marine_02")] = true,
    [GetHashKey("s_m_y_marine_01")] = true,
    [GetHashKey("s_m_y_marine_02")] = true,
    [GetHashKey("s_m_y_marine_03")] = true,
    [GetHashKey("s_m_y_armymech_01")] = true,
    [GetHashKey("s_m_m_highsec_01")] = true,
    [GetHashKey("s_m_m_highsec_02")] = true,
    [GetHashKey("s_m_m_ciasec_01")] = true,
    [GetHashKey("s_m_m_chemsec_01")] = true,
    [GetHashKey("s_m_m_fiboffice_01")] = true,
    [GetHashKey("s_m_m_fiboffice_02")] = true,
    [GetHashKey("s_m_m_fibsec_01")] = true,
    [GetHashKey("s_m_y_autopsy_01")] = true,
    [GetHashKey("s_m_y_swat_01")] = true,
    [GetHashKey("u_m_y_corpse_01")] = true,
    [GetHashKey("s_m_m_ammucountry")] = true,
    [GetHashKey("s_m_m_armoured_01")] = true,
    [GetHashKey("s_m_m_armoured_02")] = true,
    [GetHashKey("s_m_m_bouncer_01")] = true,
    [GetHashKey("s_m_m_chemwork_01")] = true,
    [GetHashKey("s_m_m_customergen_01")] = true,
    [GetHashKey("s_m_m_security_01")] = true,
    [GetHashKey("s_m_m_gentransport")] = true,
}

local function IsServicePed(model)
    return serviceModels[model] or false
end

local function DeleteTargetPeds()
    local peds = GetGamePool("CPed")
    for i = 1, #peds do
        local ped = peds[i]
        if ped and DoesEntityExist(ped) then
            if not IsPedAPlayer(ped) then
                if Elit3NoPeds.ClearAllPeds then
                    SetEntityAsNoLongerNeeded(ped)
                    DeletePed(ped)
                elseif Elit3NoPeds.ClearServices then
                    local model = GetEntityModel(ped)
                    if IsServicePed(model) then
                        SetEntityAsNoLongerNeeded(ped)
                        DeletePed(ped)
                    end
                end
            end
        end
    end
end

CreateThread(function()
    while true do
        Wait(Elit3NoPeds.CheckInterval)
        DeleteTargetPeds()
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if Elit3NoPeds.ClearAllPeds then
            SetPedDensityMultiplierThisFrame(0.0)
            SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
        elseif Elit3NoPeds.ClearServices then
            SetPedDensityMultiplierThisFrame(0.1)
            SetScenarioPedDensityMultiplierThisFrame(0.1, 0.1)
        end
    end
end)

RegisterNetEvent("elit3-nopeds:doClear")
AddEventHandler("elit3-nopeds:doClear", function()
    DeleteTargetPeds()
end)
