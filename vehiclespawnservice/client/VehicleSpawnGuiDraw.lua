--[[
    IMPORTANT NOTE: This class is helper for VehicleSpawnGui class (there are a lot of abstract functions).
    There are only drawing functions. If you want to see action implementation, go to VehicleSpawnGui class.
]]

VehicleSpawnGuiDraw = {}

function VehicleSpawnGuiDraw:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function VehicleSpawnGuiDraw:create()

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
    addEventHandler("onClientGUIChanged", self.searchBox, function () self:searchByCriteria() end , false)

    self.filters = {}
    self.filters.cars = self:createFilterCheckBox(0.1, 0.22, 0.15, 0.1, "Cars", VehicleMainType.CAR)
    self.filters.boats = self:createFilterCheckBox(0.3, 0.22, 0.2, 0.1, "Boats", VehicleMainType.BOAT)
    self.filters.planes = self:createFilterCheckBox(0.5, 0.22, 0.2, 0.1, "Planes", VehicleMainType.PLANE)
    self.filters.helicopters = self:createFilterCheckBox(0.7, 0.22, 0.3, 0.1, "Helicopters", VehicleMainType.HELICOPTER)
    self.filters.trailers = self:createFilterCheckBox(0.1, 0.30, 0.2, 0.1, "Trailers", VehicleMainType.TRAILER)
    self.filters.trains = self:createFilterCheckBox(0.3, 0.30, 0.2, 0.1, "Trains", VehicleMainType.TRAIN)
    self.filters.bikes = self:createFilterCheckBox(0.5, 0.30, 0.2, 0.1, "Bikes", VehicleMainType.BIKE)
    self.filters.motorbikes = self:createFilterCheckBox(0.7, 0.30, 0.3, 0.1, "Motorbikes", VehicleMainType.MOTORBIKE)

    self:createButton( 0.1, 0.41, 0.3, 0.05, "Select/Unselect all", function () self:selectUnselectFiltersStatuses() end)

    self.results = self:createResultsTable(0.1, 0.50, 0.8, 0.31, {{"Model", 0.15}, {"Name", 0.50}, {"Type", 0.20}})
    self:refreshResults(VehicleService:findByCriteria(nil))

    self:createButton( 0.53, 0.85, 0.2, 0.1, "Spawn", function () self:spawnSelectedVehicle() end)
    self:createButton( 0.75, 0.85, 0.2, 0.1, "Close", function () self:hide() end)
end

function VehicleSpawnGuiDraw:createFilterCheckBox(x, y, width, height, text, criteria)
    local filter = GuiCheckBox(x, y, width, height, text, true, true, self.window)
    addEventHandler("onClientGUIClick", filter, function () self:searchByCriteria() end, false)
    return { obj = filter, criteria = criteria }
end

function VehicleSpawnGuiDraw:createResultsTable(x, y, width, height, colsData)

    local table = GuiGridList(x, y, width, height, true, self.window)

    for _, col in ipairs(colsData) do
        table:addColumn(col[1], col[2])
    end

    addEventHandler( "onClientGUIDoubleClick", table, function () self:spawnSelectedVehicle() end, false)
    return table
end

function VehicleSpawnGuiDraw:createButton(x, y, width, height, text, actionFunction)
    local btn = GuiButton (x, y, width, height, text, true, self.window)
    addEventHandler("onClientGUIClick", btn, function () actionFunction() end, false)
end