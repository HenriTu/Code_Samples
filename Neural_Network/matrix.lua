local Matrix = {}

Matrix.new = function (self, rows, columns, elementFunction)
    --[[
    For example, if we set rows := 3, columns := 3,
    and elementFunction := function (i, j) return i + j end,
    we would get the matrix

    2  3  4
    3  4  5
    4  5  6
    ]]--

    local matrix = {}
    for i = 1, rows do
        matrix[i] = {}
        for j = 1, columns do
            matrix[i][j] = elementFunction(i, j)
        end
    end

    self.__index = self
    setmetatable(matrix, self)

    return matrix
end

Matrix.newFromTable = function (self, matrix)
    -- For example, matrix := {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}}

    self.__index = self
    setmetatable(matrix, self)

    return matrix
end

Matrix.rows = function (self)
    return #self -- the number of rows
end

Matrix.columns = function (self)
    return #self[1] -- the number of columns
end

Matrix.transpose = function (self)
    local elementFunction = function (i, j) return self[j][i] end

    return Matrix:new(self:columns(), self:rows(), elementFunction)
end

Matrix.map = function (self, mappingFunction)
    --Applies the mapping function to each matrix element and produces a new matrix.

    local elementFunction = function (i, j) return mappingFunction(self[i][j]) end

    return Matrix:new(self:rows(), self:columns(), elementFunction)
end

Matrix.print = function (self)
    for _, row in ipairs(self) do
        print(unpack(row))
    end
    print("")
end

-- Set metamethods

Matrix.__add = function (matrix1, matrix2)
    local elementFunction = function (i, j) return matrix1[i][j] + matrix2[i][j] end

    return Matrix:new(matrix1:rows(), matrix1:columns(), elementFunction)
end

Matrix.__sub = function (matrix1, matrix2)
    local elementFunction = function (i, j) return matrix1[i][j] - matrix2[i][j] end

    return Matrix:new(matrix1:rows(), matrix1:columns(), elementFunction)
end

Matrix.__mul = function (matrix1, matrix2)
    local commonDimension = matrix1:columns() -- same as matrix2:rows()

    local elementFunction = function (i, j)
        local sum = 0
        for k = 1, commonDimension do
            sum = sum + matrix1[i][k] * matrix2[k][j]
        end

        return sum
    end

    return Matrix:new(matrix1:rows(), matrix2:columns(), elementFunction)
end

return Matrix