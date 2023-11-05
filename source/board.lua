Board = {nil}

Board.canvas = love.graphics.newCanvas(BOARD_SIZE, BOARD_SIZE)

function Board:initialize()
	self.canvas:renderTo(function()		
		love.graphics.clear(LIGHT_COLOR)
		love.graphics.clear(DARK_COLOR)
		for i = 0, 7 do
			for j = 0, 7 do
				if i%2 == j%2 then
					love.graphics.rectangle("fill", i*SQUARE_SIZE, j*SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE)
				end
			end
		end
	end)
end
