return function (args)
    local food = {}
    food.color = args.color

    food.move = function (self, grid, snake)
        local possibleFoodPositions = {}

        for iFood = 2, grid.gridYCount - 1 do
            for jFood = 2, grid.gridXCount - 1 do
                if not snake:containsSegment(iFood, jFood) then
                    table.insert(possibleFoodPositions, {i = iFood, j = jFood})
                end
            end
        end
        
        self.position = possibleFoodPositions[love.math.random(#possibleFoodPositions)]
    end

    food.draw = function(self, grid)
        grid:drawSingleCell(self.position.i, self.position.j, self.color)
    end

    return food
end