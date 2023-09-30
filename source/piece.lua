function movementPawn()
    local result = {}
    for i = 1, 8 do
        result[i] = {}
        for j = 1, 8 do
            result[i][j] = false
        end
    end
    return result
end

function Piece(colour, type)
    return {
        colour = colour,
        type = type,
        movement = movementPawn,
        draw = function(self, x, y)
            love.graphics.draw(texture[colour*6+type], x, y)
        end
    }
end