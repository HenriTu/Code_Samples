local Grid = require("grid")

love.graphics.setBackgroundColor(1, 1, 1)
local grid = Grid(70, 50, 8, 2)
love.keyboard.setKeyRepeat(true)

function love.update(dt) grid:update(dt) end

function love.draw() grid:draw() end

function love.keypressed() grid:updateCells() end
