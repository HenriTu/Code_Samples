function getInputs(inputString, delimiter)
    local inputsTable = {}
    for match in inputString:gmatch("([^" .. delimiter .. "]+)") do
        table.insert(inputsTable, tonumber(match) / 255 * 0.99 + 0.01)
    end
    return inputsTable
end

function prepareData(str)
    local data = {}

    data.answer = tonumber(str:sub(1, 1))
    data.inputs = getInputs(str:sub(2), ",")
    data.targets = {}
    for i = 0, 9 do
        if i == data.answer then
            table.insert(data.targets, 0.99)
        else
            table.insert(data.targets, 0.01)
        end
    end

    return data
end

return {prepareData = prepareData}
