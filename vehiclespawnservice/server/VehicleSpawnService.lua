VehicleSpawnService = {}

local LOG = Logger:new("VehicleSpawnService")

function VehicleSpawnService:createVehicleInFrontOfElement(vehicle, element)
    local interior = element:getInterior()
    local dimension = element:getDimension()
    local distance = vehicle.spawnDistance or 10
    local spawnPosition = element.matrix.position + element.matrix.forward * distance
    local spawnRotation = element.matrix:getRotation()
    spawnRotation:setZ(spawnRotation:getZ() + 90)
    LOG:debug("Creating vehicle with model ID: " .. vehicle.modelId .. " at position [x: " .. spawnPosition.x .. " | y: " .. spawnPosition.y .. " | z: " .. spawnPosition.z .. "].")
    local vehicleElement = Vehicle(vehicle.modelId, spawnPosition, spawnRotation)
    vehicleElement:setInterior(interior)
    vehicleElement:setDimension(dimension)
end