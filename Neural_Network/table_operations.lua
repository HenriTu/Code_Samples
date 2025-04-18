function findMaxIndexAndValue(t)
    if #t == 0 then return nil, nil end

    local maxIndex = 1
    local maxValue = t[1]

    for i = 2, #t do
        if t[i] > maxValue then
            maxIndex = i
            maxValue = t[i]
        end
    end

    return maxIndex, maxValue
end

return {findMaxIndexAndValue = findMaxIndexAndValue}