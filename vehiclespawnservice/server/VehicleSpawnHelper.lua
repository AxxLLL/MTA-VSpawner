VehicleSpawnHelper = {}

function VehicleSpawnHelper:prepareMultipleResultsString(vehicles)
    local maxResults = 5
    local presentedString = "Founded " .. Colors.white.hex .. #vehicles .. Colors.cmd.info.hex .. " vehicles: " .. Colors.white.hex .. self:concatVehicleNames(vehicles, maxResults) .. Colors.cmd.info.hex .. "."

    if maxResults < #vehicles then
        presentedString = presentedString:sub(1, presentedString:len() - 1)
        presentedString = presentedString .. " (and " .. Colors.white.hex .. #vehicles - maxResults  .. Colors.cmd.info.hex .. " more)."
    end

    return presentedString
end

function VehicleSpawnHelper:concatVehicleNames(vehicles, maxResults)

    local results = {}

    for i, vehicle in ipairs(vehicles) do
        table.insert(results, vehicle.name)
        if i == maxResults then break end
    end

    return table.concat(results, Colors.cmd.info.hex .. ", " .. Colors.white.hex)
end