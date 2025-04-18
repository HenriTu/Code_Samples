return function (snake)

    controls = {}

    controls.keypressed = function (key)
        local directionQueue = snake.directionQueue

        if key == "right"
        and directionQueue[#directionQueue] ~= "right"
        and directionQueue[#directionQueue] ~= "left" then
            table.insert(directionQueue, "right")

        elseif key == "left"
        and directionQueue[#directionQueue] ~= "left"
        and directionQueue[#directionQueue] ~= "right" then
            table.insert(directionQueue, "left")

        elseif key == "up"
        and directionQueue[#directionQueue] ~= "up"
        and directionQueue[#directionQueue] ~= "down" then
            table.insert(directionQueue, "up")

        elseif key == "down"
        and directionQueue[#directionQueue] ~= "down"
        and directionQueue[#directionQueue] ~= "up" then
            table.insert(directionQueue, "down")
        end
    end

    return controls
end