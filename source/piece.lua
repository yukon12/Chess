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

    --front
    if y+offset >= 1 and y+offset <= 8 and modes[1].map[x][y+offset]==0 then
        result[x][y+offset] = true
    end

    --front left
    if y+offset >= 1 and y+offset <= 8 and x-1>=1 and modes[1].map[x-1][y+offset]>0 and modes[1].pieces[modes[1].map[x-1][y+offset]].colour == (self.colour+1)%2 then
        result[x-1][y+offset] = true
    end

    --front right
    if y+offset >= 1 and y+offset <= 8 and x+1<=8 and modes[1].map[x+1][y+offset]>0 and modes[1].pieces[modes[1].map[x+1][y+offset]].colour == (self.colour+1)%2 then
        result[x+1][y+offset] = true
    end

    --double front
    if y == 7 and self.colour == 0 and modes[1].map[x][y+2*offset]==0 then
        result[x][y+2*offset] = true
    end
    if y == 2 and self.colour == 1 and modes[1].map[x][y+2*offset]==0 then
        result[x][y+2*offset] = true
    end

    return result
end

function movementKnight(self, x, y)
    --initialize array
    local result = {}
    for i = 1, 8 do
        result[i] = {}
        for j = 1, 8 do
            result[i][j] = false
        end
    end

    local moves = {
        {x = -2, y = -1}, {x = -2, y = 1},
        {x = -1, y = -2}, {x = -1, y = 2},
        {x = 1, y = -2}, {x = 1, y = 2},
        {x = 2, y = -1}, {x = 2, y = 1}
    }

    for i, v in pairs(moves) do
        if x+v.x >= 1 and x+v.x <= 8 and y+v.y >= 1 and y+v.y <= 8 and not (modes[1].map[x+v.x][y+v.y]>0 and modes[1].pieces[modes[1].map[x+v.x][y+v.y]].colour == self.colour) then
            result[x+v.x][y+v.y] = true
        end
    end

    return result
end

function movementRook(self, x, y)
    --initialize array
    local result = {}
    for i = 1, 8 do
        result[i] = {}
        for j = 1, 8 do
            result[i][j] = false
        end
    end

    for i = 1, 7 do
        if x-i >= 1 and x-i <= 8 then
            if modes[1].map[x-i][y]>0 then
                if modes[1].pieces[modes[1].map[x-i][y]].colour == (self.colour+1)%2 then
                    result[x-i][y] = true
                end
                break
            else
                result[x-i][y] = true
            end
        end
    end

    for i = 1, 7 do
        if x+i >= 1 and x+i <= 8 then
            if modes[1].map[x+i][y]>0 then
                if modes[1].pieces[modes[1].map[x+i][y]].colour == (self.colour+1)%2 then
                    result[x+i][y] = true
                end
                break
            else
                result[x+i][y] = true
            end
        end
    end

    for i = 1, 7 do
        if y-i >= 1 and y-i <= 8 then
            if modes[1].map[x][y-i]>0 then
                if modes[1].pieces[modes[1].map[x][y-i]].colour == (self.colour+1)%2 then
                    result[x][y-i] = true
                end
                break
            else
                result[x][y-i] = true
            end
        end
    end

    for i = 1, 7 do
        if y+i >= 1 and y+i <= 8 then
            if modes[1].map[x][y+i]>0 then
                if modes[1].pieces[modes[1].map[x][y+i]].colour == (self.colour+1)%2 then
                    result[x][y+i] = true
                end
                break
            else
                result[x][y+i] = true
            end
        end
    end

    return result
end

function movementBishop(self, x, y)
    --initialize array
    local result = {}
    for i = 1, 8 do
        result[i] = {}
        for j = 1, 8 do
            result[i][j] = false
        end
    end

    for i = 1, 7 do
        if x-i >= 1 and x-i <= 8 and y-i >= 1 and y-i <= 8 then
            if modes[1].map[x-i][y-i]>0 then
                if modes[1].pieces[modes[1].map[x-i][y-i]].colour == (self.colour+1)%2 then
                    result[x-i][y-i] = true
                end
                break
            else
                result[x-i][y-i] = true
            end
        end
    end

    for i = 1, 7 do
        if x+i >= 1 and x+i <= 8 and y+i >= 1 and y+i <= 8 then
            if modes[1].map[x+i][y+i]>0 then
                if modes[1].pieces[modes[1].map[x+i][y+i]].colour == (self.colour+1)%2 then
                    result[x+i][y+i] = true
                end
                break
            else
                result[x+i][y+i] = true
            end
        end
    end

    for i = 1, 7 do
        if x+i >= 1 and x+i <= 8 and y-i >= 1 and y-i <= 8 then
            if modes[1].map[x+i][y-i]>0 then
                if modes[1].pieces[modes[1].map[x+i][y-i]].colour == (self.colour+1)%2 then
                    result[x+i][y-i] = true
                end
                break
            else
                result[x+i][y-i] = true
            end
        end
    end

    for i = 1, 7 do
        if x-i >= 1 and x-i <= 8 and y+i >= 1 and y+i <= 8 then
            if modes[1].map[x-i][y+i]>0 then
                if modes[1].pieces[modes[1].map[x-i][y+i]].colour == (self.colour+1)%2 then
                    result[x-i][y+i] = true
                end
                break
            else
                result[x-i][y+i] = true
            end
        end
    end

    return result
end

function movementQueen(self, x, y)
    --initialize array
    local result = {}
    local bishop = movementBishop(self, x, y)
    local rook = movementRook(self, x, y)
    for i = 1, 8 do
        result[i] = {}
        for j = 1, 8 do
            result[i][j] = false
            if bishop[i][j] or rook[i][j] then
                result[i][j] = true
            end
        end
    end
    return result
end

function movementKing(self, x, y)
    --initialize array
    local result = {}
    for i = 1, 8 do
        result[i] = {}
        for j = 1, 8 do
            result[i][j] = false
        end
    end

    local moves = {
        {x = 0, y = -1},
        {x = 0, y = 1},
        {x = -1, y = 0},
        {x = 1, y = 0},
        {x = -1, y = -1},
        {x = -1, y = 1},
        {x = 1, y = -1},
        {x = 1, y = 1}
    }

    for i, v in pairs(moves) do
        if x+v.x >= 1 and x+v.x <= 8 and y+v.y >= 1 and y+v.y <= 8 and not (modes[1].map[x+v.x][y+v.y]>0 and modes[1].pieces[modes[1].map[x+v.x][y+v.y]].colour == self.colour) then
            result[x+v.x][y+v.y] = true
        end
    end

    return result
end

function Piece(colour, type)
    local movementFunction
    if type == 0 then
        movementFunction = movementPawn
    elseif type == 1 then
        movementFunction = movementRook
    elseif type == 2 then
        movementFunction = movementKnight
    elseif type == 3 then
        movementFunction = movementBishop
    elseif type == 4 then
        movementFunction = movementQueen
    elseif type == 5 then
        movementFunction = movementKing
    end
    return {
        colour = colour, --colour is 0 (white) or 1 (black)
        type = type, --number from 0 to 5 representing type of piece
        movement = movementFunction, --funtion that returns field on which each piece can move (different based on the type)
        draw = function(self, x, y)
            love.graphics.draw(texture[colour*6+type], x, y)
        end
    }
end