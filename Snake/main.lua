local Snake = require("snake")
local Food = require ("food")
local Grid = require("grid")
local GameController = require("game_controller")
local Timer = require("timer")
local Controls = require("controls")
local Text = require("text")

-- Initialize the game

local grid = Grid{
    gridXCount = 20,
    gridYCount = 20,
    cellSize = 15,
    gapSize = 1,
    innerColor = {0.86, 0.86, 0.86},
    borderColor = {0.5, 0.5, 0.5}
}

local snake = Snake{color = {1, 0, 1}}
snake:reset()

local controls = Controls(snake)

local food = Food{color = {1, 0.3, 0.3}}
food:move(grid, snake)

local scoreText = Text{x = 10, y = 10, size = 24, color = {1, 0, 1}}
local stepsText = Text{x = 150, y = 10, size = 24, color = {1, 0, 1}}

local timer = Timer()

local gameController = GameController(grid, snake, food, timer)

love.graphics.setBackgroundColor(1, 1, 1)

-- Updating

function love.update(dt)
    timer:update(dt)
    if timer.value >= 0.1 and snake.isAlive then
        snake:move(grid, food)
        timer:reset()
    elseif not snake.isAlive then
        gameController.reset()
    end
    scoreText.string = "Score: " .. tostring(snake.score)
    stepsText.string = "Steps: " .. tostring(snake.steps)
end

-- Drawing

function love.draw() 
    grid:draw()
    food:draw(grid)
    snake:draw(grid)
    scoreText:draw()
    stepsText:draw()
end

-- Keys

function love.keypressed(key) controls.keypressed(key) end