local Cell = require("entities/cell")
local generalHelpers = require("helper_functions/general_helpers")
local entityHandling = require("helper_functions/entity_handling")

return function ()
    local cellManager = {}
    cellManager.cells = {}

    cellManager.update = function(self, dt, foods)
        local index = 1
        while index <= #self.cells do
            local cell = self.cells[index]
            cell:update(dt, self.cells, foods)
            if cell.delete == true then
                self:destroyCell(index, cell)
            elseif cell.canDivide == true then
                self:divideCell(index, cell)
            else
                index = index + 1
            end
        end
    end

    cellManager.draw = function(self)
        for _, cell in ipairs(self.cells) do
            cell:draw()
        end
    end

    cellManager.spawnCell = function(self, foods)
        local color = generalHelpers.randomColor()
        local cellsAndFoods = generalHelpers.combineLists(self.cells, foods)
        local position = entityHandling.findFreePlace(cellsAndFoods, 10)
        if position then
            table.insert(self.cells, Cell(position.x, position.y, color))
        end
    end

    cellManager.destroyCell = function(self, index, cell)
        cell:destroy()
        table.remove(self.cells, index)
    end

    cellManager.divideCell = function(self, index, cell)
        local x, y = cell.body:getPosition()
        local color = cell.color

        self:destroyCell(index, cell)
        table.insert(self.cells, Cell(x + 1, y, color))
        table.insert(self.cells, Cell(x - 1, y, color))
    end

    return cellManager
end