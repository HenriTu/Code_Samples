local NeuralNetwork = require("neural_network")
local Text = require("text")
local data = require("data")
local tableOperations = require("table_operations")

local neuralNetwork = NeuralNetwork:new({784, 200, 10}, 0.2)
local contents = love.filesystem.read("mnist_train_100.csv")

for line in contents:gmatch("[^\r\n]+") do
    local trainingData = data.prepareData(line)
    neuralNetwork:train(trainingData.inputs, trainingData.targets)
end

contents = love.filesystem.read("mnist_test_10.csv")

local results = {correct = 0, wrong = 0}
for line in contents:gmatch("[^\r\n]+") do
    local testData = data.prepareData(line)

    local outputs = neuralNetwork:query(testData.inputs)
    local maxIndex = tableOperations.findMaxIndexAndValue(outputs:transpose()[1])
    if maxIndex - 1 == testData.answer then 
        results["correct"] = results["correct"] + 1
    else
        results["wrong"] = results["wrong"] + 1
    end
end

local sum = results["correct"] + results["wrong"]
local resultString = "Oikein: " .. tostring(results["correct"]) .. " / " .. tostring(sum) .. " = " .. tostring(results["correct"] / sum * 100) .. " %"
local resultText = Text{x = 10, y = 10, size = 24, color = {1, 1, 1}, string = resultString}

function love.draw() resultText:draw() end

function love.keypressed(key)
    if key == "escape" then love.event.quit(0) end
end