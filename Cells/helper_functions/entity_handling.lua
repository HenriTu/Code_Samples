local bodyMath = require("math/body_math")
local Vector = require("math/vector")
local vectorMath = require("math/vector_math")

function searchNearestAndSecondNearestEntity(targetEntity, entities)
    local nearest = entities[1]
    local secondNearest = entities[1]
    if #entities > 1 then secondNearest = entities[2] end
    local R = bodyMath.distance(targetEntity, nearest)
    local minR = R
    local minSecondR = R
    for _, entity in ipairs(entities) do
        R = bodyMath.distance(targetEntity, entity)
        if R < minR then
            minSecondR = minR
            minR = R
            secondNearest = nearest
            nearest = entity
        else
            if R < minSecondR then
                minSecondR = R
                secondNearest = entity
            end
        end
    end

    return {nearest, secondNearest}
end

function findFreePlace(entities, maxTries)
    local i = 1
    while true do
        ::start::
        if i > maxTries then return nil end

        local x = math.random(40, love.graphics.getWidth() - 40)
        local y = math.random(40, love.graphics.getHeight() - 40)

        for _, entity in ipairs(entities) do
            if entity.body then
                local bodyX, bodyY = entity.body:getPosition()
                if vectorMath.norm(Vector(x - bodyX, y - bodyY)) < 100 then
                    i = i + 1
                    goto start
                end
            end
        end

        return {x = x, y = y}
    end
end

return {
    searchNearestAndSecondNearestEntity = searchNearestAndSecondNearestEntity,
    findFreePlace = findFreePlace
}

