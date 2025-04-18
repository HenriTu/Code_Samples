local CellManager = require("entities/cell_manager")
local FoodManager = require("entities/food_manager")
local world = require("entities/world")

love.window.setFullscreen(true, "desktop")
love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
math.randomseed(os.time())

local cellManager = CellManager()
local foodManager = FoodManager(1)

function love.update(dt)
    cellManager:update(dt, foodManager.foods)
    foodManager:update(dt, cellManager.cells)
    world:update(dt)
end

function love.draw()
    cellManager:draw()
    foodManager:draw()
end

function love.keypressed(key)
    if key == "escape" then love.event.quit(0) end
    if key == "space" then
        cellManager:spawnCell(foodManager.foods)
    end
end
