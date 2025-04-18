return function (grid, snake, food, timer)

    local gameController = {}

    gameController.reset = function ()
        snake:reset()
        timer:reset()
        food:move(grid, snake)
    end

    return gameController
end