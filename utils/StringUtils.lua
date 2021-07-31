String = {}

function String:isEmpty(stringToTest)
    return stringToTest == nil or stringToTest == ''
end

function string:startsWithIgnoreCase(startsString)
    local searchForName = startsString:lower()
    local searchLen = startsString:len()
    return self:sub(1, searchLen) == searchForName
end

function string:isNumber()
    return tonumber(self) ~= nil and true
end