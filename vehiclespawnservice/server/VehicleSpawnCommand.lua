local LOG = Logger:new("VehicleSpawnCommand")

local function spawnVehicleCommandHandler(player, _, nameOrModelId)

    if String:isEmpty(nameOrModelId) then

        if not player:getData("vSpawnerInfoShown", false) then
            player:outputChat("[VSpawner] Usage: /v [Vehicle name / Model ID]", Colors.cmd.description.r, Colors.cmd.description.g, Colors.cmd.description.b)
        end

        player:triggerEvent("spawnVehicleCommandEvent", player)
        player:setData("vSpawnerInfoShown", true, false)
        return
    end

    LOG:debug("Player '" .. player:getName() .. "' is trying to create vehicle with name or ID: '" .. nameOrModelId .. "'.")

    local vehicles = VehicleService:findVehiclesByNameOrModelId(nameOrModelId)

    if #vehicles == 1 then
        player:outputChat("Creating vehicle with name '" .. Colors.white.hex .. vehicles[1].name .. Colors.cmd.success.hex .. "' (ID: " .. Colors.white.hex .. vehicles[1].modelId .. Colors.cmd.success.hex .. ").", Colors.cmd.success.r, Colors.cmd.success.g, Colors.cmd.success.b, true)
        VehicleSpawnService:createVehicleInFrontOfElement(vehicles[1], player)
    elseif #vehicles > 1 then
        local results = VehicleSpawnHelper:prepareMultipleResultsString(vehicles)
        player:outputChat("There are more than one vehicle with name '" .. Colors.white.hex .. nameOrModelId .. Colors.cmd.info.hex .. "'.", Colors.cmd.info.r, Colors.cmd.info.g, Colors.cmd.info.b, true)
        player:outputChat(results, Colors.cmd.info.r, Colors.cmd.info.g, Colors.cmd.info.b, true)
    else
        player:outputChat("Cannot find any vehicle with name/ID '" .. Colors.white.hex .. nameOrModelId .. Colors.cmd.error.hex .. "'.", Colors.cmd.error.r, Colors.cmd.error.g, Colors.cmd.error.b, true)
    end

end
addCommandHandler("vehicle", spawnVehicleCommandHandler)
addCommandHandler("veh", spawnVehicleCommandHandler)
addCommandHandler("v", spawnVehicleCommandHandler)