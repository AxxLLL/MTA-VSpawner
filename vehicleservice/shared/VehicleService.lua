VehicleService = {}

local LOG = Logger:new("VehicleService")

function VehicleService:findVehiclesByNameOrModelId(nameOrModelId)

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

function VehicleService:findByModelId(modelId)

    LOG:debug("Looking for vehicle with model ID: " .. modelId .. ".")

    for _, vehicle in ipairs(VehicleModelsData) do
        if vehicle.modelId == modelId then
            return vehicle
        end
    end

    return false
end

function VehicleService:findAllByNameStartsWith(name)

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

function VehicleService:findByCriteria(criteria)

    if not criteria then
        return VehicleModelsData
    end

    return VehicleModelsData --TODO
end