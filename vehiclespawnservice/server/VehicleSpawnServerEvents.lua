function spawnVehicleGuiEventHandler(vehicle)
    if client then
        VehicleSpawnService:createVehicleInFrontOfElement(vehicle, client)
    end
end
addEvent( "spawnVehicleGuiEvent", true )
addEventHandler( "spawnVehicleGuiEvent", root, spawnVehicleGuiEventHandler )