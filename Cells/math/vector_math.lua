local Vector = require("math/vector")

function norm(vector) return math.sqrt(vector.x ^ 2 + vector.y ^ 2) end

function normalize(vector)
    local norm = norm(vector)
    return Vector(vector.x / norm, vector.y / norm)
end

function dot(first_vector, second_vector)
    return first_vector.x * second_vector.x + first_vector.y * second_vector.y
end

function perpendicular(vector) return Vector(-vector.y, vector.x) end

return {
    norm = norm,
    normalize = normalize,
    dot = dot,
    perpendicular = perpendicular
}

