board = {nil}

-- Two dimensional array storing types of pieces on each square.
board.matrix = DEFAULT_PIECE_PLACEMENT

board.backgroundCanvas = love.graphics.newCanvas(BOARD_SIZE, BOARD_SIZE)

board.pieceCanvas = love.graphics.newCanvas(BOARD_SIZE, BOARD_SIZE)

-- Checks if there is any piece on the given square.
function board:isPiece(column, file)
	if self.matrix[column][file] > 0 then
		return true
	end
	return false
end

function board:updateBackgroundCanvas()
	self.backgroundCanvas:renderTo(function()		
		love.graphics.clear(LIGHT_COLOR)
		love.graphics.clear(DARK_COLOR)
		for column = 1, 8 do
			for file = 1, 8 do
				if column%2 == file%2 then
					love.graphics.rectangle("fill", (column-1)*SQUARE_SIZE, (file-1)*SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE)
				end
			end
		end
	end)
end

function board:updatePieceCanvas()
	self.pieceCanvas:renderTo(function()
		for column = 1, 8 do
			for file = 1, 8 do
				piece.draw(self.matrix[column][file], column, file)
			end
		end
	end)
end

-- Initialize Board module.
function board:initialize()
	self:updateBackgroundCanvas()
	self:updatePieceCanvas()
end

function board:draw()
	love.graphics.draw(self.backgroundCanvas, 0, 0)
	love.graphics.draw(self.pieceCanvas, 0, 0)
end
