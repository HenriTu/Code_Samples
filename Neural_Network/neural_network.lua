local Matrix = require("matrix")
local matrixAlgebra = require("matrix_algebra")

local NeuralNetwork = {}

NeuralNetwork.new = function (self, nodesTable, learningRate)
    --[[ 
    The argument "nodesTable" must contain at least two elements. 
    The first element is the number of input nodes,
    the last element is the number of output nodes,
    and the middle elements indicate the number of nodes in the hidden layers.
    --]]

    local neuralNetwork = {}

    neuralNetwork.nodesTable = nodesTable
    neuralNetwork.learningRate = learningRate
    neuralNetwork.activationFunction = function (x) return 1 / (1 + math.exp(-x)) end -- sigmoid
    neuralNetwork.numberOfWeightMatrices = #nodesTable - 1

    neuralNetwork.weightMatrices = {}
    for k = 1, #nodesTable - 1 do 
        local weightMatrix = Matrix:new(
            nodesTable[k + 1],
            nodesTable[k],
            function (i, j) return math.random() - 0.5 end
        )
        table.insert(neuralNetwork.weightMatrices, weightMatrix)
    end

    self.__index = self
    setmetatable(neuralNetwork, self)

    return neuralNetwork
end

NeuralNetwork.query = function (self, inputsTable)
    local inputs = Matrix:newFromTable({inputsTable}):transpose()

    local outputs
    for i = 1, self.numberOfWeightMatrices do
        if outputs then inputs = outputs end
        outputs = self.weightMatrices[i] * inputs
        outputs = outputs:map(self.activationFunction)
    end

    return outputs
end

NeuralNetwork.train = function (self, inputsTable, targetsTable)
    local inputs = Matrix:newFromTable({inputsTable}):transpose()
    local targets = Matrix:newFromTable({targetsTable}):transpose()

    local allLayerOutputs = {}
    local outputs
    for i = 1, self.numberOfWeightMatrices do
        if outputs then inputs = outputs end
        outputs = self.weightMatrices[i] * inputs
        outputs = outputs:map(self.activationFunction)
        allLayerOutputs[i] = outputs
    end

    local allLayerErrors = {}
    allLayerErrors[self.numberOfWeightMatrices] = targets - allLayerOutputs[self.numberOfWeightMatrices]

    for i = self.numberOfWeightMatrices - 1, 1, -1 do
        allLayerErrors[i] = self.weightMatrices[i + 1]:transpose() * allLayerErrors[i + 1]
    end

    for i = 1, self.numberOfWeightMatrices do
        local previousOutputs
        if i == 1 then
            previousOutputs = Matrix:newFromTable({inputsTable}):transpose()
        else
            previousOutputs = allLayerOutputs[i - 1]
        end
        
        local change = matrixAlgebra.elementwiseOperation(
            function (x, y) return self.learningRate * x * y * (1 - y) end,
            allLayerErrors[i],
            allLayerOutputs[i]
        )

        local weightCorrections = change * previousOutputs:transpose()

        self.weightMatrices[i] = self.weightMatrices[i] + weightCorrections
    end
end

return NeuralNetwork