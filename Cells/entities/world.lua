local function preSolve(fixture1, fixture2, coll)
    local entity1 = fixture1:getUserData()
    local entity2 = fixture2:getUserData()
    if entity1.preSolve then entity1:preSolve(entity2) end
    if entity2.preSolve then entity2:preSolve(entity1) end
end

local world = love.physics.newWorld(0, 0, true)
world:setCallbacks(preSolve, nil, nil, nil)

return world
