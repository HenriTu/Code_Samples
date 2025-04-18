return function(x, y, cellSize)
    local cell = {}
    cell.x = x
    cell.y = y
    cell.cellSize = cellSize
    cell.colorAlive = {1, 0, 1}
    cell.colorDead = {0.86, 0.86, 0.86}
    cell.colorActive = {0, 1, 1}
    cell.isAlive = false

    cell.draw = function(self, isActive)
        if isActive then
            color = self.colorActive
        elseif self.isAlive then
            color = self.colorAlive
        else
            color = self.colorDead
        end

        love.graphics.setColor(color)
        love.graphics.rectangle("fill", self.x, self.y, self.cellSize, self.cellSize)
    end

    return cell
end
