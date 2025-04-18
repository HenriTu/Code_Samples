function filter(filterFunction, elements)
    local filteredElements = {}
    for _, element in ipairs(elements) do
        if filterFunction(element) then
            table.insert(filteredElements, element)
        end
    end

    return filteredElements
end

function randomColor()
    return {
        math.random(0, 255) / 255, math.random(0, 255) / 255,
        math.random(0, 255) / 255
    }
end

function combineLists(...)
    local combinedList = {}
    for _, list in ipairs({...}) do
        for _, element in ipairs(list) do
            table.insert(combinedList, element)
        end
    end

    return combinedList
end

return {
    filter = filter,
    randomColor = randomColor,
    combineLists = combineLists
}