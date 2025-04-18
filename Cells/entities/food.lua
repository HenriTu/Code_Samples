local world = require("entities/world")

return function(x, y, color)
    local food = {}
    food.body = love.physics.newBody(world, x, y, "dynamic")
    food.shape = love.physics.newCircleShape(20)
    food.fixture = love.physics.newFixture(food.body, food.shape, 1)
    food.fixture:setCategory(1)
    food.fixture:setMask(2)
    food.fixture:setUserData(food)
    food.tag = "food"
    food.delete = false
    food.color = color

    food.draw = function(self)
        love.graphics.setColor(self.color)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(),
                             self.shape:getRadius())
    end

    food.preSolve = function(self, otherEntity)
        if otherEntity.tag == "cell" then self.delete = true end
    end

    food.destroy = function(self)
        self.fixture:destroy()
        self.body:destroy()
    end

    return food
end
