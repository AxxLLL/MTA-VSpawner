local resourceName = getResourceName(resource)

Logger = {
    sourceName = ""
}

function Logger:new(sourceName)
    self.__index = self
    return setmetatable({ sourceName = sourceName }, self)
end

function Logger:debug(message)
    outputDebugString("<" .. resourceName .. ": " .. self.sourceName .. "> " .. message)
end