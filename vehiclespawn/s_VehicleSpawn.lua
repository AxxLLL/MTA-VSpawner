VehicleSpawn = {}

local LOG = Logger:new("VehicleSpawn")

function VehicleSpawn:findVehiclesByNameOrModelId(nameOrModelId)

    LOG:debug("Searching for vehicle with name or ID: '" .. nameOrModelId .. "'.")

    local modelId = tonumber(nameOrModelId)

    if modelId then
        local vehicle = self:findByModelId(modelId)

        if not vehicle then
            return {}
        end

        return {vehicle}
    else
        return self:findAllByNameStartsWith(nameOrModelId)
    end
end

function VehicleSpawn:findByModelId(modelId)

    LOG:debug("Looking for vehicle with model ID: " .. modelId .. ".")

    for _, vehicle in ipairs(VehicleModelsData) do
        if vehicle.modelId == modelId then
            return vehicle
        end
    end

    return false
end

function VehicleSpawn:findAllByNameStartsWith(name)

    LOG:debug("Looking for vehicle with name: '" .. name .. "'.")

    local foundedModels = {}

    for _, vehicle in pairs(VehicleModelsData) do
        local lModelName = vehicle.name:lower()
        if lModelName:startsWithIgnoreCase(name) then
            table.insert(foundedModels, vehicle)
        end
    end

    return foundedModels
end

function VehicleSpawn:createVehicleInFrontOfElement(vehicle, element)
    local distance = vehicle.spawnDistance or 10
    local spawnPosition = element.matrix.position + element.matrix.forward * distance
    LOG:debug("Creating vehicle with model ID: " .. vehicle.modelId .. " at position [x: " .. spawnPosition.x .. " | y: " .. spawnPosition.y .. " | z: " .. spawnPosition.z .. "].")
    Vehicle(vehicle.modelId, spawnPosition)
end