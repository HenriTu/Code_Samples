local world = require("entities/world")
local bodyMath = require("math/body_math")
local entityHandling = require("helper_functions/entity_handling")

return function(x, y, color)
    local cell = {}
    cell.body = love.physics.newBody(world, x, y, "dynamic")
    cell.shape = love.physics.newCircleShape(35)
    cell.fixture = love.physics.newFixture(cell.body, cell.shape, 0.05)
    cell.fixture:setCategory(1)
    cell.fixture:setMask(2)
    cell.fixture:setUserData(cell)
    cell.fixture:setSensor(true)
    cell.fixtureColl = love.physics.newFixture(cell.body, cell.shape, 0.05)
    cell.fixtureColl:setCategory(2)
    cell.fixtureColl:setMask(1)
    cell.fixtureColl:setUserData(cell)
    cell.body:setLinearDamping(1)
    cell.tag = "cell"
    cell.size = 0
    cell.color = color
    cell.lifeTime = 20
    cell.delete = false
    cell.canDivide = false

    cell.update = function(self, dt, cells, foods)
        if #foods > 0 then
            local targetFoods =
                entityHandling.searchNearestAndSecondNearestEntity(self, foods)
            local targetFood = targetFoods[1]
            local d = bodyMath.distance(self, targetFood)
            for _, c in ipairs(cells) do
                if bodyMath.distance(c, targetFood) < d then
                    targetFood = targetFoods[2]
                    break
                end
            end
            local unitVector = bodyMath.unitVector(self, targetFood)
            self.body:applyForce(30 * unitVector.x, 30 * unitVector.y)
        end

        self.lifeTime = self.lifeTime - dt
        if self.lifeTime <= 0 then self.delete = true end
    end

    cell.draw = function(self)
        local color
        if self.lifeTime > 10 then
            color = self.color
        else
            local t = self.lifeTime / 10
            local r = t * self.color[1] + (1 - t) * 0.55
            local g = t * self.color[2] + (1 - t) * 0.55
            local b = t * self.color[3] + (1 - t) * 0.55
            color = {r, g, b}
        end

        love.graphics.setColor(color)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(),
                             self.fixture:getShape():getRadius())
    end

    cell.preSolve = function(self, otherEntity)
        if otherEntity.tag == "food" then
            self:grow()
            self.lifeTime = 20
        end
    end

    cell.grow = function(self)
        local shape = self.fixture:getShape()
        local newRadius = shape:getRadius() + 3
        shape:setRadius(newRadius)
        self.fixtureColl:getShape():setRadius(newRadius)
        self.size = self.size + 1
        if self.size >= 10 then self.canDivide = true end
    end

    cell.destroy = function(self)
        self.fixture:destroy()
        self.body:destroy()
    end

    return cell
end
