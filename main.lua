require "source/constants"
require "source/board"

function love.load()
	Board:initialize()	
end

function love.update()

end

function love.draw()
	love.graphics.draw(Board.canvas, 0, 0)
end
