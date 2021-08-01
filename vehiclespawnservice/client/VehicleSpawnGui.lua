VehicleSpawnGui = {}

function VehicleSpawnGui:create()

    if self:exists() then
        return
    end

    self.window = GuiWindow(0.70, 0.55, 0.25, 0.40, "Vehicle Spawner", true)
    self.window:setAlpha(1.0)
    self.window:setSizable(false)
    self.window:setMovable(true)
    self.window:setVisible(false)

    self.searchBox = GuiEdit(0.1, 0.1, 0.8, 0.1, "", true, self.window)
    self.searchBox:setMaxLength(32)
    addEventHandler("onClientGUIChanged", self.searchBox, function () VehicleSpawnGui:searchByCriteria() end , false)

    self.filters = {}
    self.filters.cars = self:createFilterCheckBox(0.1, 0.22, 0.15, 0.1, "Cars")
    self.filters.boats = self:createFilterCheckBox(0.3, 0.22, 0.2, 0.1, "Boats")
    self.filters.planes = self:createFilterCheckBox(0.5, 0.22, 0.2, 0.1, "Planes")
    self.filters.helicopters = self:createFilterCheckBox(0.7, 0.22, 0.3, 0.1, "Helicopters")
    self.filters.trailers = self:createFilterCheckBox(0.1, 0.30, 0.2, 0.1, "Trailers")
    self.filters.trains = self:createFilterCheckBox(0.3, 0.30, 0.2, 0.1, "Trains")
    self.filters.bikes = self:createFilterCheckBox(0.5, 0.30, 0.2, 0.1, "Bikes")
    self.filters.motorbikes = self:createFilterCheckBox(0.7, 0.30, 0.3, 0.1, "Motorbikes")

    self:createButton( 0.1, 0.41, 0.3, 0.05, "Select/Unselect all", function () self:selectUnselectFiltersStatuses() end)

    self.results = self:createResultsTable(0.1, 0.50, 0.8, 0.31, {{"Model", 0.15}, {"Name", 0.50}, {"Type", 0.20}})
    VehicleSpawnGui:refreshResults(VehicleService:findByCriteria(nil))

    self:createButton( 0.53, 0.85, 0.2, 0.1, "Spawn", function () VehicleSpawnGui:spawnSelectedVehicle() end)
    self:createButton( 0.75, 0.85, 0.2, 0.1, "Close", function () self:hide() end)
end

function VehicleSpawnGui:createFilterCheckBox(x, y, width, height, text)
    local filter = GuiCheckBox(x, y, width, height, text, true, true, self.window)
    addEventHandler("onClientGUIClick", filter, function () VehicleSpawnGui:searchByCriteria() end, false)
    return filter
end

function VehicleSpawnGui:createResultsTable(x, y, width, height, colsData)

    local table = GuiGridList(x, y, width, height, true, self.window)

    for _, col in ipairs(colsData) do
        table:addColumn(col[1], col[2])
    end

    addEventHandler( "onClientGUIDoubleClick", table, function () VehicleSpawnGui:spawnSelectedVehicle() end, false)
    return table
end

function VehicleSpawnGui:createButton(x, y, width, height, text, actionFunction)
    local btn = GuiButton (x, y, width, height, text, true, self.window)
    addEventHandler("onClientGUIClick", btn, function () actionFunction() end, false)
end

function VehicleSpawnGui:exists() return self.window ~= nil and true end

function VehicleSpawnGui:show() self:setVisible(true) end

function VehicleSpawnGui:hide() self:setVisible(false) end

function VehicleSpawnGui:isVisible()

    if not self:exists() then
        return
    end

    return self.window:getVisible()
end

function VehicleSpawnGui:setVisible(visible)

    if not self:exists() then
        return
    end

    visible = visible and true
    self.window:setVisible(visible)
    showCursor(visible)
end

function VehicleSpawnGui:selectUnselectFiltersStatuses()

    local active = 0
    for _, filter in pairs(self.filters) do
        if filter:getSelected() then
            active = active + 1
        end
    end

    local newStatus = not (active >= 4)
    for _, filter in pairs(self.filters) do
        filter:setSelected(newStatus)
    end

    self:searchByCriteria()
end

function VehicleSpawnGui:searchByCriteria()

    local results = VehicleService:findByCriteria({
        name = self.searchBox:getText(),
        isCar = {filter = self.filters.cars:getSelected(), type = VehicleMainType.CAR},
        isBoat = {filter = self.filters.boats:getSelected(), type = VehicleMainType.BOAT},
        isPlane = {filter = self.filters.planes:getSelected(), type = VehicleMainType.PLANE},
        isHelicopter = {filter = self.filters.helicopters:getSelected(), type = VehicleMainType.HELICOPTER},
        isBike = {filter = self.filters.bikes:getSelected(), type = VehicleMainType.BIKE},
        isMotorbike = {filter = self.filters.motorbikes:getSelected(), type = VehicleMainType.MOTORBIKE},
        isTrailer = {filter = self.filters.trailers:getSelected(), type = VehicleMainType.TRAILER},
        isTrain = {filter = self.filters.trains:getSelected(), type = VehicleMainType.TRAIN}
    })

    self:refreshResults(results)
end

function VehicleSpawnGui:refreshResults(newResults)

    self.results:clear()

    if not newResults then
        return
    end

    for _, vehicle in ipairs(newResults) do
        self.results:addRow(vehicle.modelId, vehicle.name, vehicle.mainType.name)
    end
end

function VehicleSpawnGui:spawnSelectedVehicle()

    if localPlayer:isDead() then
        outputChatBox("You must be alive to use this command.", Colors.cmd.error.r, Colors.cmd.error.g, Colors.cmd.error.b)
        return
    end

    local selectedRow = self.results:getSelectedItem()

    if not selectedRow or selectedRow == -1 then
        return
    end

    local selectedVehicleModelId = self.results:getItemText(selectedRow, 1)
    local vehicle = VehicleService:findByModelId(selectedVehicleModelId)
    triggerServerEvent("spawnVehicleGuiEvent", localPlayer, vehicle)
    outputChatBox("Creating vehicle with name '" .. Colors.white.hex .. vehicle.name .. Colors.cmd.success.hex .. "' (ID: " .. Colors.white.hex .. vehicle.modelId .. Colors.cmd.success.hex .. ").", Colors.cmd.success.r, Colors.cmd.success.g, Colors.cmd.success.b, true)
    self:hide()
end