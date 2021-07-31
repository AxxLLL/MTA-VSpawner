bindKey( "v", "down", function ()
    VehicleSpawnGui:create()
    VehicleSpawnGui:setVisible(not VehicleSpawnGui:isVisible())
end)