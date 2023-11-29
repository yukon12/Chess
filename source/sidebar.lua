sidebar = {nil}

sidebar.canvas = love.graphics.newCanvas(SIDEBAR_SIZE, BOARD_SIZE)

sidebar.buttonHover = {false, false, false}

function sidebar:undo()
	board.pieceMatrix = COPY_MATRIX(board.previousPieceMatrix)
	miscellaneous:switchTurn()
	board:updateStateMatrix(-1, -1)
	board:updatePieceCanvas()
	board:updateHighlightCanvas()
end

function sidebar:restart()
	board.pieceMatrix = COPY_MATRIX(DEFAULT_PIECE_PLACEMENT)
	miscellaneous.turn = "white"
	board:updateStateMatrix(-1, -1)
	board:updatePieceCanvas()
	board:updateHighlightCanvas()
end

function sidebar:exit()
	love.event.quit()
end

function sidebar:updateCanvas()
	self.canvas:renderTo(function()
		love.graphics.clear(SIDEBAR_COLOR)
		love.graphics.setColor(DEFAULT_COLOR)
		love.graphics.printf(VERSION, resources.smallFont, 0, 0, SIDEBAR_SIZE, "right")
		love.graphics.printf(TITLE, resources.bigFont, 0, 20, SIDEBAR_SIZE, "center")
		if miscellaneous.turn == "white" then
			love.graphics.setColor(LIGHT_COLOR)
		else
			love.graphics.setColor(DARK_COLOR)
		end
		love.graphics.printf(miscellaneous.turn.." to move", resources.smallFont, 0, 120, SIDEBAR_SIZE, "center")

		if self.buttonHover[1] then love.graphics.setColor(DEFAULT_COLOR) else love.graphics.setColor(MAGENTA_COLOR) end
		love.graphics.printf("undo", resources.smallFont, 0, 400, SIDEBAR_SIZE, "center")
		if self.buttonHover[2] then love.graphics.setColor(DEFAULT_COLOR) else love.graphics.setColor(MAGENTA_COLOR) end
		love.graphics.printf("restart", resources.smallFont, 0, 440, SIDEBAR_SIZE, "center")
		if self.buttonHover[3] then love.graphics.setColor(DEFAULT_COLOR) else love.graphics.setColor(MAGENTA_COLOR) end
		love.graphics.printf("exit", resources.smallFont, 0, 480, SIDEBAR_SIZE, "center")

		love.graphics.setColor(DEFAULT_COLOR)
	end)
end

function sidebar:initialize()
	self:updateCanvas()
end

function sidebar:draw()
	love.graphics.draw(self.canvas, BOARD_SIZE, 0)
end
