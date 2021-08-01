function spawnVehicleCommandEventHandler()
    VehicleSpawnGui:createIfNotExistsAndShow()
end
addEvent( "spawnVehicleCommandEvent", true )
addEventHandler( "spawnVehicleCommandEvent", localPlayer, spawnVehicleCommandEventHandler )