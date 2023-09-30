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
        map = preloadMap,
        pieces = preloadPieces,
        mp = {x = 0, y = 0},
        buttonDown = false,
        buttonPressed = false,
        stage = 1,
        clickedX = 0,
        clickedY = 0,
        possibleMovements = {},
        update = function(self)
            self.buttonPressed = false
            if not self.buttonDown and love.mouse.isDown(1) then
                self.buttonPressed = true
            end
            self.buttonDown = love.mouse.isDown(1)

            self.mp.x, self.mp.y = love.mouse.getPosition()

            if self.buttonPressed then
                self.clickedX = math.floor(self.mp.x/100)+1
                self.clickedY = math.floor(self.mp.y/100)+1

                if self.stage == 1 then
                    if not (self.map[self.clickedX][self.clickedY] == 0) then
                        if self.pieces[self.map[self.clickedX][self.clickedY]].colour == self.turnColour then
                            self.stage = 2
                            self.possibleMovements = self.pieces[self.map[self.clickedX][self.clickedY]]:movement()
                        end
                    end
                end
            end
        end,
        draw = function(self)
            love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
            for i = 1, 8 do
                for j = 1, 8 do
                    if (i%2)==(j%2) then
                        love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
                        love.graphics.rectangle("fill", 100*(i-1), 100*(j-1), 100, 100)
                    end
                    if not (self.map[i][j] == 0) then
                        love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
                        self.pieces[self.map[i][j]]:draw((i-1)*100+18, (j-1)*100+18)
                        if self.stage == 1 and self.pieces[self.map[i][j]].colour == self.turnColour then
                            love.graphics.setColor(0.5, 0.5, 1.0, 0.5)
                            love.graphics.circle("fill", (i-1)*100+50, (j-1)*100+50, 50)
                        elseif self.stage == 2 then
                            if self.possibleMovements[i][j] == true then
                                love.graphics.setColor(0.1, 0.5, 0.5, 0.5)
                                love.graphics.circle("fill", (i-1)*100+50, (j-1)*100+50, 50)
                            end
                        end
                    end
                end
            end
        end
    }
end