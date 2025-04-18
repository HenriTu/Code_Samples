-- All entities must have physical bodies
local Vector = require("math/vector")
local vectorMath = require("math/vector_math")

function differenceVector(firstEntity, secondEntity)
    local firstBodyX, firstBodyY = firstEntity.body:getPosition()
    local secondBodyX, secondBodyY = secondEntity.body:getPosition()
    return Vector(secondBodyX - firstBodyX, secondBodyY - firstBodyY)
end

function distance(firstEntity, secondEntity)
    return vectorMath.norm(differenceVector(firstEntity, secondEntity))
end

function unitVector(firstEntity, secondEntity)
    return vectorMath.normalize(differenceVector(firstEntity, secondEntity))
end

function speed(entity)
    return vectorMath.norm(Vector(entity.body:getLinearVelocity()))
end

return {distance = distance, unitVector = unitVector, speed = speed}
