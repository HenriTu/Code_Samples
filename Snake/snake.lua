return function (args)
    local snake = {}
    snake.color = args.color

    snake.reset = function (self)
        self.segments = {
            {i = 5, j = 5},
            {i = 5, j = 4},
            {i = 5, j = 3},
        }
        self.directionQueue = {"right"}    
        self.isAlive = true
        self.score = 0
        self.steps = 0
    end

    snake.draw = function (self, grid)
        for _, segment in ipairs(self.segments) do
            grid:drawSingleCell(segment.i, segment.j, self.color)
        end
    end

    snake.getNextPosition = function (self)

        if #self.directionQueue > 1 then
            table.remove(self.directionQueue, 1)
        end

        local iNext = self.segments[1].i
        local jNext = self.segments[1].j

        local first = self.directionQueue[1]

        if first == "right" then
            jNext = jNext + 1
        elseif first == "left" then
            jNext = jNext - 1
        elseif first == "down" then
            iNext = iNext + 1
        elseif first == "up" then
            iNext = iNext - 1
        end

        return iNext, jNext
    end

    snake.updateIsAlive = function (self, iNext, jNext, grid)
        for segmentIndex, segment in ipairs(self.segments) do
            if segmentIndex ~= #self.segments and iNext == segment.i and jNext == segment.j then
                self.isAlive = false
                return
            end
        end
        if iNext == 1 or iNext == grid.gridYCount or jNext == 1 or jNext == grid.gridXCount then
            self.isAlive = false
            return
        end

        self.isAlive = true
    end

    snake.move = function (self, grid, food)
        local iNext, jNext = self:getNextPosition()
        self:updateIsAlive(iNext, jNext, grid)
        if self.isAlive then
            table.insert(self.segments, 1, {i = iNext, j = jNext})
            self.steps = self.steps + 1
            if iNext == food.position.i and jNext == food.position.j then
                self.score = self.score + 1
                food:move(grid, self)
            else
                table.remove(self.segments)
            end
        end
    end

    snake.containsSegment = function (self, i, j)
        for _, segment in ipairs(self.segments) do
            if segment.i == i and segment.j == j then
                return true
            end
        end

        return false
    end

    return snake
end