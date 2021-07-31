function spawnVehicleCommandEventHandler()
    VehicleSpawnGui:create()
    VehicleSpawnGui:show()
end
addEvent( "spawnVehicleCommandEvent", true )
addEventHandler( "spawnVehicleCommandEvent", localPlayer, spawnVehicleCommandEventHandler )