local LOG = Logger:new("VehicleSpawnCommand")

local function spawnVehicleCommandHandler(player, _, nameOrModelId)

    if String:isEmpty(nameOrModelId) then
        outputChatBox("[VSpawner] Usage: /v [Vehicle name / Model ID]", player, g_Colors.cmd.description.r, g_Colors.cmd.description.g, g_Colors.cmd.description.b)
        return
    end

    LOG:debug("Player '" .. player:getName() .. "' is trying to create vehicle with name or ID: '" .. nameOrModelId .. "'.")

    local vehicles = VehicleSpawn:findVehiclesByNameOrModelId(nameOrModelId)

    if #vehicles == 1 then
        outputChatBox("Creating vehicle with name '" .. g_Colors.white.hex .. vehicles[1].name .. g_Colors.cmd.success.hex .. "' (ID: " .. g_Colors.white.hex .. vehicles[1].modelId .. g_Colors.cmd.success.hex .. ").", player, g_Colors.cmd.success.r, g_Colors.cmd.success.g, g_Colors.cmd.success.b, true)
        VehicleSpawn:createVehicleInFrontOfElement(vehicles[1], player)
    elseif #vehicles > 1 then
        outputChatBox("There are more than one vehicle with name '" .. g_Colors.white.hex .. nameOrModelId .. g_Colors.cmd.info.hex .. "'.", player, g_Colors.cmd.info.r, g_Colors.cmd.info.g, g_Colors.cmd.info.b, true)
        outputChatBox("Founded " .. g_Colors.white.hex .. #vehicles .. g_Colors.cmd.info.hex .. " vehicles: " .. VehicleSpawnHelper:concatVehiclesNames(vehicles) .. g_Colors.cmd.info.hex .. ".", player, g_Colors.cmd.info.r, g_Colors.cmd.info.g, g_Colors.cmd.info.b, true)
    else
        outputChatBox("Cannot find any vehicle with name/ID '" .. g_Colors.white.hex .. nameOrModelId .. g_Colors.cmd.error.hex .. "'.", player, g_Colors.cmd.error.r, g_Colors.cmd.error.g, g_Colors.cmd.error.b, true)
    end

end
addCommandHandler("vehicle", spawnVehicleCommandHandler)
addCommandHandler("v", spawnVehicleCommandHandler)
addCommandHandler("car", spawnVehicleCommandHandler)
addCommandHandler("c", spawnVehicleCommandHandler)