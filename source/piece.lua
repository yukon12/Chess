function movementPawn(self, x, y)
    --initialize array
    local result = {}
    for i = 1, 8 do
        result[i] = {}
        for j = 1, 8 do
            result[i][j] = false
        end
    end

    --set offset to -1 if colour is white or 1 if it is black
    local offset
    if self.colour == 0 then
        offset = -1
    else
        offset = 1
    end

    if modes[1].map[x][y+offset]==0 and y+offset >= 0 and y+offset <= 9 then
        result[x][y+offset] = true
    end

    return result
end

function Piece(colour, type)
    return {
        colour = colour, --colour is 0 (white) or 1 (black)
        type = type, --number from 0 to 5 representing type of piece
        movement = movementPawn, --funtion that returns field on which each piece can move (different based on the type)
        draw = function(self, x, y)
            love.graphics.draw(texture[colour*6+type], x, y)
        end
    }
end