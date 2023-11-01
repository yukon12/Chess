require "source/title"
require "source/piece"
require "source/game"

function love.load()
    modeNumber = 0
    modes = {}
    modes[0] = Title()
    modes[1] = Game()

    --textures 0-5 are white pieces
    --textures 6-11 are black pieces
    texture = {}
    texture[0] = love.graphics.newImage("resource/white_pawn.png")
    texture[1] = love.graphics.newImage("resource/white_rook.png")
    texture[2] = love.graphics.newImage("resource/white_knight.png")
    texture[3] = love.graphics.newImage("resource/white_bishop.png")
    texture[4] = love.graphics.newImage("resource/white_queen.png")
    texture[5] = love.graphics.newImage("resource/white_king.png")
    texture[6] = love.graphics.newImage("resource/black_pawn.png")
    texture[7] = love.graphics.newImage("resource/black_rook.png")
    texture[8] = love.graphics.newImage("resource/black_knight.png")
    texture[9] = love.graphics.newImage("resource/black_bishop.png")
    texture[10] = love.graphics.newImage("resource/black_queen.png")
    texture[11] = love.graphics.newImage("resource/black_king.png")
end

function love.keyreleased(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.update()
    modes[modeNumber]:update()
end

function love.draw()
    modes[modeNumber]:draw()
end