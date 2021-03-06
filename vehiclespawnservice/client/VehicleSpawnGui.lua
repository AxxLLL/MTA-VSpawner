VehicleSpawnGui = VehicleSpawnGuiDraw:new()

function VehicleSpawnGui:exists() return self.window ~= nil and true end

function VehicleSpawnGui:hide() self:setVisible(false) end

function VehicleSpawnGui:createIfNotExistsAndShow()

    if not self:exists() then
        self:create()
    end

    self:setVisible(true)
end

function VehicleSpawnGui:setVisible(visible)

    if not self:exists() then
        return
    end

    visible = visible and true
    self.window:setVisible(visible)
    showCursor(visible)
end

function VehicleSpawnGui:isVisible()

    if not self:exists() then
        return false
    end

    return self.window:getVisible()
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

    local criteria = {
        name = self.searchBox:getText()
    }

    for _, filter in pairs(self.filters) do
        if not filter.obj:getSelected() then
            table.insert(criteria, filter.criteria)
        end
    end

    local results = VehicleService:findByCriteria(criteria)
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