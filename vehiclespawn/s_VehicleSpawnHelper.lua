VehicleSpawnHelper = {}

function VehicleSpawnHelper:concatVehiclesNames(vehicles)

    local results = {}

    for _, vehicle in ipairs(vehicles) do
        table.insert(results, vehicle.name)
    end

    return table.concat(results, g_Colors.cmd.info.hex .. ", " .. g_Colors.white.hex)
end