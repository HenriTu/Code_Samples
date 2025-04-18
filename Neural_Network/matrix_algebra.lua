local Matrix = require("matrix")

function elementwiseOperation(operation, ...)
    --[[
    This can be applied to several matrices of the same dimension. It applies the operation function
    to the matrix elements at the position (i, j) and produces a new matrix. 
    For example, we could compute the matrix sum X + Y + Z by defining the operation fuction as follows:
    operation := function (x, y, z) return x + y + z end.
    Obviously, the operation function can be more complicated.
    ]]--

    local firstMatrix = select(1, ...)
    local rows = firstMatrix:rows()
    local columns = firstMatrix:columns()

    local resultMatrix = {}
    for i = 1, rows do
        resultMatrix[i] = {}
        for j = 1, columns do
            local arguments = {}
            for _, matrix in ipairs({...}) do
                table.insert(arguments, matrix[i][j])
            end

            resultMatrix[i][j] = operation(unpack(arguments))
        end
    end

    return Matrix:newFromTable(resultMatrix)
end

return {elementwiseOperation = elementwiseOperation}