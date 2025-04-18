local Cell = require("cell")

return function(gridXCount, gridYCount, cellSize, gapSize)
    local grid = {}

    grid.gridXCount = gridXCount
    grid.gridYCount = gridYCount
    grid.cellSize = cellSize
    grid.gapSize = gapSize

    grid.centerX = love.graphics.getWidth() / 2
    grid.centerY = love.graphics.getHeight() / 2
    grid.width = gridXCount * cellSize + (gridXCount - 1) * gapSize
    grid.height = gridYCount * cellSize + (gridYCount - 1) * gapSize

    grid.left = grid.centerX - grid.width / 2
    grid.right = grid.centerX + grid.width / 2
    grid.top = grid.centerY - grid.height / 2
    grid.bottom = grid.centerY + grid.height / 2

    grid.iSelected = nil
    grid.jSelected = nil

    grid.cells = {}
    for i = 1, gridYCount do
        grid.cells[i] = {}
        for j = 1, gridXCount do
            local cellX = grid.left + (j - 1) * (cellSize + gapSize)
            local cellY = grid.top + (i - 1) * (cellSize + gapSize)

            grid.cells[i][j] = Cell(cellX, cellY, cellSize)
        end
    end

    grid.update = function(self, dt)
        local mouseX = love.mouse.getX()
        local mouseY = love.mouse.getY()

        if (mouseX < self.left or mouseX > self.right or mouseY <
            self.top or mouseY > self.bottom) then

            self.iSelected = nil
            self.jSelected = nil
        else
            local size = self.cellSize + self.gapSize

            local i = math.floor((mouseY - self.top) / size + 1)
            local j = math.floor((mouseX - self.left) / size + 1)

            self.iSelected = i
            self.jSelected = j

            if love.mouse.isDown(1) then
                self.cells[i][j].isAlive = true
            elseif love.mouse.isDown(2) then
                self.cells[i][j].isAlive = false
            end
        end
    end

    grid.draw = function(self, mouseX, mouseY)
        for i = 1, self.gridYCount do
            for j = 1, self.gridXCount do
                local isActive = (i == self.iSelected and j == self.jSelected)
                grid.cells[i][j]:draw(isActive)
            end
        end
    end

    grid.updateCells = function(self)
        local newCells = {}

        for i = 1, self.gridYCount do
            newCells[i] = {}
            for j = 1, self.gridXCount do
                local neighborCount = 0

                for k = -1, 1 do
                    for l = -1, 1 do
                        if not (k == 0 and l == 0) and self.cells[i + k] and
                            self.cells[i + k][j + l] and
                            self.cells[i + k][j + l].isAlive then
                            neighborCount = neighborCount + 1
                        end
                    end
                end

                local currentCell = self.cells[i][j]
                local newCell = Cell(currentCell.x, currentCell.y,
                                     currentCell.cellSize)
                newCell.isAlive = (neighborCount == 3) or
                                      (currentCell.isAlive and neighborCount ==
                                          2)
                newCells[i][j] = newCell
            end
        end

        self.cells = newCells
    end

    return grid
end
