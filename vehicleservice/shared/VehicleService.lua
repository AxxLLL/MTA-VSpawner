VehicleService = {}

local LOG = Logger:new("VehicleService")

function VehicleService:findVehiclesByNameOrModelId(nameOrModelId)

    LOG:debug("Searching for vehicle with name or ID: '" .. nameOrModelId .. "'.")

    if nameOrModelId:isNumber() then
        local vehicle = self:findByModelId(nameOrModelId)

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

    local searchForModelId = tonumber(modelId)

    for _, vehicle in ipairs(VehicleModelsData) do
        if vehicle.modelId == searchForModelId then
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

    local results = Table:copy(VehicleModelsData)

    if not criteria then
        LOG:debug("No criteria. Returning full list of vehicles.")
        return results
    end

    if not String:isEmpty(criteria.name) then
        LOG:debug("Searching vehicles by name criteria: '" .. criteria.name .. "'.")
        results = self:findAllByNameStartsWith(criteria.name)
    end

    for _, filterElement in ipairs(criteria) do
        if VehicleServiceCriteriaFilterHelper:isValidCriteriaElement(filterElement) then
            LOG:debug("Removing vehicles by type '" .. filterElement.name .. "' criteria.")
            VehicleServiceCriteriaFilterHelper:removeByVehicleType(results, filterElement)
        end
    end

    return results
end