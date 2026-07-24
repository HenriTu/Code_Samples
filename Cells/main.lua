local CellManager = require("entities/cell_manager")
local FoodManager = require("entities/food_manager")
local Text = require("entities/text")
local world = require("entities/world")

love.window.setFullscreen(true, "desktop")
love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
math.randomseed(os.time())

local cellManager = CellManager()
local foodManager = FoodManager(1)
local controlsText = Text{
    string = "Space: Add cell  |  Esc: Quit",
    x = 8,
    y = love.graphics.getHeight() - 24,
    size = 16,
    color = {0.29, 0.17, 0.13}
}

function love.update(dt)
    cellManager:update(dt, foodManager.foods)
    foodManager:update(dt, cellManager.cells)
    world:update(dt)
end

function love.draw()
    cellManager:draw()
    foodManager:draw()
    controlsText:draw()
end

function love.keypressed(key)
    if key == "escape" then love.event.quit(0) end
    if key == "space" then
        cellManager:spawnCell(foodManager.foods)
    end
end
