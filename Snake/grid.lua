local Cell = require("cell")

return function(args)
    local grid = {}

    grid.gridXCount = args.gridXCount
    grid.gridYCount = args.gridYCount
    grid.cellSize = args.cellSize
    grid.gapSize = args.gapSize
    grid.innerColor = args.innerColor
    grid.borderColor = args.borderColor

    grid.centerX = love.graphics.getWidth() / 2
    grid.centerY = love.graphics.getHeight() / 2
    grid.width = grid.gridXCount * grid.cellSize + (grid.gridXCount - 1) * grid.gapSize
    grid.height = grid.gridYCount * grid.cellSize + (grid.gridYCount - 1) * grid.gapSize

    grid.left = grid.centerX - grid.width / 2
    grid.right = grid.centerX + grid.width / 2
    grid.top = grid.centerY - grid.height / 2
    grid.bottom = grid.centerY + grid.height / 2

    grid.cells = {}
    for i = 1, grid.gridYCount do
        grid.cells[i] = {}
        for j = 1, grid.gridXCount do
            local cellX = grid.left + (j - 1) * (grid.cellSize + grid.gapSize)
            local cellY = grid.top + (i - 1) * (grid.cellSize + grid.gapSize)
            grid.cells[i][j] = Cell(cellX, cellY, grid.cellSize)
        end
    end

    grid.draw = function (self)
        for i = 1, self.gridYCount do
            for j = 1, self.gridXCount do
                if i == 1 or i == self.gridYCount or j == 1 or j == self.gridXCount then
                    self.cells[i][j]:draw(self.borderColor)
                else
                    self.cells[i][j]:draw(self.innerColor)
                end
            end
        end
    end

    grid.drawSingleCell = function (self, i, j, color)
        self.cells[i][j]:draw(color)
    end

    return grid
end