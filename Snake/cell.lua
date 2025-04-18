return function(x, y, cellSize)
    local cell = {}

    cell.x = x
    cell.y = y
    cell.cellSize = cellSize

    cell.draw = function (self, color)
        love.graphics.setColor(color)
        love.graphics.rectangle("fill", self.x, self.y, self.cellSize, self.cellSize)
    end

    return cell
end