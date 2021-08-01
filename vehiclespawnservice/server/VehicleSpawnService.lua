VehicleSpawnService = {}

local LOG = Logger:new("VehicleSpawnService")

function VehicleSpawnService:createVehicleInFrontOfElement(vehicle, element)
    local distance = vehicle.spawnDistance or 10
    local spawnPosition = element.matrix.position + element.matrix.forward * distance
    local spawnRotation = element.matrix:getRotation()
    spawnRotation:setZ(spawnRotation:getZ() + 90)
    LOG:debug("Creating vehicle with model ID: " .. vehicle.modelId .. " at position [x: " .. spawnPosition.x .. " | y: " .. spawnPosition.y .. " | z: " .. spawnPosition.z .. "].")
    Vehicle(vehicle.modelId, spawnPosition, spawnRotation)
end