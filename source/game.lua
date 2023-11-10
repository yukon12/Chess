function Game()
    preloadMap = {}
    for i = 1, 8 do
        preloadMap[i] = {}
        for j = 1, 8 do
            preloadMap[i][j] = 0
        end
    end

    preloadMap[1][7] = 1
    preloadMap[2][7] = 1
    preloadMap[3][7] = 1
    preloadMap[4][7] = 1
    preloadMap[5][7] = 1
    preloadMap[6][7] = 1
    preloadMap[7][7] = 1
    preloadMap[8][7] = 1
    preloadMap[1][8] = 2
    preloadMap[2][8] = 3
    preloadMap[3][8] = 4
    preloadMap[4][8] = 5
    preloadMap[5][8] = 6
    preloadMap[6][8] = 4
    preloadMap[7][8] = 3
    preloadMap[8][8] = 2

    preloadMap[1][2] = 7
    preloadMap[2][2] = 7
    preloadMap[3][2] = 7
    preloadMap[4][2] = 7
    preloadMap[5][2] = 7
    preloadMap[6][2] = 7
    preloadMap[7][2] = 7
    preloadMap[8][2] = 7
    preloadMap[1][1] = 8
    preloadMap[2][1] = 9
    preloadMap[3][1] = 10
    preloadMap[4][1] = 11
    preloadMap[5][1] = 12
    preloadMap[6][1] = 10
    preloadMap[7][1] = 9
    preloadMap[8][1] = 8

    preloadPieces = {}
    for i = 0, 11 do
        preloadPieces[i+1] = Piece(math.floor(i/6), i%6)
    end

    return {
        turnColour = 0,
        --map is 8x8 array which stores indices of pieces that are placed on each field (0 if there is no piece)
        map = preloadMap,
        --pieces is 12 element long array consisting of objects of class Piece
        pieces = preloadPieces,
        mp = {x = 0, y = 0},
        --same as in title.lua
        buttonDown = false,
        buttonPressed = false,
        --first stage is when the player has to chose a piece to be moved
        --second stage is when the piece to be moved is chosen and player has to chose field to move the piece on
        stage = 1,
        --clickedX and clickedY store coordinates of the field that was last clicked with a cursor
        clickedX = 0,
        clickedY = 0,
        --oldClickedX and oldClickedY represent past value of clickedX and clickedY
        oldClickedX = 0,
        oldClickedY = 0,
        --possibleMovements is an array that stores fields that chosen piece can move onto
        possibleMovements = {},
        update = function(self)
            --button logic, same as in title.lua
            self.buttonPressed = false
            if not self.buttonDown and love.mouse.isDown(1) then
                self.buttonPressed = true
            end
            self.buttonDown = love.mouse.isDown(1)

            --get mouse positon
            self.mp.x, self.mp.y = love.mouse.getPosition()

            --movement logic
            if self.buttonPressed then
                self.oldClickedX = self.clickedX
                self.oldClickedY = self.clickedY
                self.clickedX = math.floor(self.mp.x/100)+1
                self.clickedY = math.floor(self.mp.y/100)+1

                if self.stage == 1 then
                    --if there is a piece on a clicked field
                    if not (self.map[self.clickedX][self.clickedY] == 0) then
                        --if clicked piece is of a good colour
                        if self.pieces[self.map[self.clickedX][self.clickedY]].colour == self.turnColour then
                            --move to stage 2 and update possibleMovements
                            self.stage = 2
                            self.possibleMovements = self.pieces[self.map[self.clickedX][self.clickedY]]:movement(self.clickedX, self.clickedY)
                        end
                    end
                elseif self.stage == 2 then
                    if self.possibleMovements[self.clickedX][self.clickedY] then
                        --move chosen piece to new field
                        self.map[self.clickedX][self.clickedY] = self.map[self.oldClickedX][self.oldClickedY]
                        self.map[self.oldClickedX][self.oldClickedY] = 0
                        self.turnColour = self.turnColour+1
                        self.turnColour = self.turnColour%2
                        self.stage = 1
                    --if there is a piece on a clicked field
                    elseif not (self.map[self.clickedX][self.clickedY] == 0) and self.pieces[self.map[self.clickedX][self.clickedY]].colour == self.turnColour then
                        --if clicked piece is of a good colour
                            --move to stage 2 and update possibleMovements
                            self.stage = 2
                            self.possibleMovements = self.pieces[self.map[self.clickedX][self.clickedY]]:movement(self.clickedX, self.clickedY)
                    else
                        self.possibleMovements = {}
                        self.stage = 1
                    end
                end
            end
        end,
        draw = function(self)
            love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
            --iterate over every field
            for i = 1, 8 do
                for j = 1, 8 do
                    --draw a field
                    if (i%2)==(j%2) then
                        love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
                        love.graphics.rectangle("fill", 100*(i-1), 100*(j-1), 100, 100)
                    end
                    --draw a piece if there is a piece on the field
                    if not (self.map[i][j] == 0) then
                        love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
                        --draw a piece in the correct place
                        self.pieces[self.map[i][j]]:draw((i-1)*100+18, (j-1)*100+18)
                        --add circle depending on the situation
                        --if we're in the first stage and the piece is of current colour then mark it blue
                        if self.pieces[self.map[i][j]].colour == self.turnColour then
                            if self.clickedX == i and self.clickedY == j then
                                love.graphics.setColor(0.5, 0.5, 1.0, 0.5) --transparent-blue
                            else
                                love.graphics.setColor(0.5, 1.0, 0.5, 0.5) --transparent-blue
                            end
                            love.graphics.rectangle("fill", (i-1)*100, (j-1)*100, 100, 100)
                        end
                    end
                    --if we're in the second stage and the chosen piece can move onto the current field then mark it red
                    if self.stage == 2 and self.possibleMovements[i][j] then
                        love.graphics.setColor(1.0, 0.5, 0.5, 0.5) --transparent-red
                        love.graphics.rectangle("fill", (i-1)*100, (j-1)*100, 100, 100)
                    end
                end
            end
        end
    }
end