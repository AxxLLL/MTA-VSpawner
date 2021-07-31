Table = {}

function Table:copy(fromTable)

    local resultTable = {}

    for _, value in ipairs(fromTable) do
        table.insert(resultTable, value)
    end

    return resultTable
end