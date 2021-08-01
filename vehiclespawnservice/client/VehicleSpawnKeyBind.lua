bindKey( "v", "down", function ()
    if VehicleSpawnGui:isVisible() then
        VehicleSpawnGui:hide()
    else
        VehicleSpawnGui:createIfNotExistsAndShow()
    end
end)