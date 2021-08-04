VehicleServiceCriteriaFilterHelper = {}

function VehicleServiceCriteriaFilterHelper:isValidCriteriaElement(element)
    return type(element) == "table"
end

function VehicleServiceCriteriaFilterHelper:removeByVehicleType(resultsTable, vehicleType)

    local tableSize = #resultsTable
    local index = 1

    while index <= tableSize do
        if resultsTable[index].mainType == vehicleType then
            table.remove(resultsTable, index)
            tableSize = #resultsTable
        else
            index = index + 1
        end
    end
end