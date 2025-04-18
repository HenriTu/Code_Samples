local Food = require("entities/food")
local generalHelpers = require("helper_functions/general_helpers")
local entityHandling = require("helper_functions/entity_handling")

return function(spawnTime)
    local foodManager = {}
    foodManager.foods = {}
    foodManager.counter = 0
    foodManager.spawnTime = spawnTime

    foodManager.update = function(self, dt, cells)
        self.counter = self.counter + dt
        if self.counter >= self.spawnTime then
            self:spawnFood(cells)
            self.counter = 0
        end

        local index = 1
        while index <= #self.foods do
            local food = self.foods[index]
            if food.delete == true then
                self:destroyFood(index, food)
            else
                index = index + 1
            end
        end
    end

    foodManager.draw = function (self)
        for _, food in ipairs(self.foods) do
            food:draw()
        end
    end

    foodManager.spawnFood = function(self, cells)
        local cellsAndFoods = generalHelpers.combineLists(cells, self.foods)
        local position = entityHandling.findFreePlace(cellsAndFoods, 10)

        if position then
            table.insert(self.foods, Food(position.x, position.y, {0, 0, 1}))
        end
    end

    foodManager.destroyFood = function(self, index, food)
        food:destroy()
        table.remove(self.foods, index)
    end

    return foodManager
end
