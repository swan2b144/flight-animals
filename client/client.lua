-- Functions
function Init()
    -- Initialize each zone
    for k, v in pairs(Config.Zones) do
        exports['PolyZone']:AddPolyZone("animal_zone_"..k, v.zone.coords,{
            debugPoly = Config.Debug,
            minZ = v.zone.height.min,
            maxZ = v.zone.height.max
        })
    end
end

-- Threads
CreateThread(function() Init() end)

-- Events
RegisterNetEvent('flight-animals:client:spawnAnimals', function(netIds, Location)
    for i = 1, #netIds do
        local APed = NetworkGetEntityFromNetworkId(netIds[i])
        TaskWanderStandard(APed, 10, 10)
        SetCanAttackFriendly(APed, false, true)
        SetEntityAsMissionEntity(APed, true, true)
    end
end)

RegisterNetEvent('flight-animals:client:checkExistence', function(data)
    for k, v in pairs(data.animalZones[data.zone]) do 
        if not DoesEntityExist(NetworkGetEntityFromNetworkId(v)) then data.animalZones[data.zone][k] = nil end end
    TriggerServerEvent("flight-animals:server:countThem", data)
end)