board = {nil}

-- Matrix array storing pieces on each square.
-- Different numbers correspond to different pieces:
-- 0 -> no piece,
-- 1 -> white pawn,
-- 2 -> white rook,
-- 3 -> white knight,
-- 4 -> white bishop,
-- 5 -> white queen,
-- 6 -> white king,
-- 7 -> black pawn,
-- 8 -> black rook,
-- 9 -> black knight,
-- 10 -> black bishop,
-- 11 -> black queen,
-- 12 -> black king.
board.pieceMatrix = DEFAULT_PIECE_PLACEMENT

-- Matrix containing state of each square.
-- Different numbers correspond to different states:
-- 0 -> default state,
-- 1 -> clicked (black),
-- 2 -> piece that can be moved (cyan),
-- 3 -> clicked piece that can be moved (yellow),
-- 4 -> possible move (magenta).
board.stateMatrix = GENERATE_MATRIX(0)

board.availableMoves = GENERATE_MATRIX(false)

board.stateColorList = {TRANSPARENT_COLOR, BLACK_COLOR, CYAN_COLOR, YELLOW_COLOR, MAGENTA_COLOR} 

board.backgroundCanvas = love.graphics.newCanvas(BOARD_SIZE, BOARD_SIZE)

board.pieceCanvas = love.graphics.newCanvas(BOARD_SIZE, BOARD_SIZE)

board.highlightCanvas = love.graphics.newCanvas(BOARD_SIZE, BOARD_SIZE)

-- Checks if there is any piece on the given square.
function board:isPiece(file, rank)
	if not self:isOnBoard(file, rank) then return false end
	if self.pieceMatrix[file][rank] > 0 then
		return true
	end
	return false
end

function board:isOnBoard(file, rank)
	if file < 1 or file > 8 then return false end
	if rank < 1 or rank > 8 then return false end
	return true
end

function board:squareColor(file, rank)
	return piece.color(self.pieceMatrix[file][rank])
end

function board:stateColor(file, rank)
	local state = self.stateMatrix[file][rank]
	return self.stateColorList[state+1]
end

function board:updateStateMatrix(file, rank)	
	for i = 1, 8 do
		self.stateMatrix[i] = {nil}
		for j = 1, 8 do
			if self:squareColor(i, j) == miscellaneous.turn then
				self.stateMatrix[i][j] = (i==file and j==rank) and 3 or 2
			else
				self.stateMatrix[i][j] = (i==file and j==rank) and 1 or 0
			end

			if self.availableMoves[i][j] then
				self.stateMatrix[i][j] = 4
			end
		end
	end
end

function board:updateAvailableMoves(file, rank)
	if self:squareColor(file, rank) ~= miscellaneous.turn then
		self.availableMoves = GENERATE_MATRIX(false)
	else
		self.availableMoves = piece.getAvailableMoves(self.pieceMatrix[file][rank], file, rank)
	end
end

function board:isAvailable(file, rank)
	return self.availableMoves[file][rank]
end

function board:move(fromFile, fromRank, toFile, toRank)
	self.pieceMatrix[toFile][toRank] = self.pieceMatrix[fromFile][fromRank]
	self.pieceMatrix[fromFile][fromRank] = 0
	miscellaneous:switchTurn()
end

function board:updateBackgroundCanvas()
	self.backgroundCanvas:renderTo(function()		
		love.graphics.clear(LIGHT_COLOR)
		love.graphics.setColor(DARK_COLOR)
		for file = 1, 8 do
			for rank = 1, 8 do
				if file%2 == rank%2 then
					love.graphics.rectangle("fill", (file-1)*SQUARE_SIZE, (rank-1)*SQUARE_SIZE, SQUARE_SIZE, SQUARE_SIZE)
				end
			end
		end
	end)
end

function board:updatePieceCanvas()
	self.pieceCanvas:renderTo(function()
		love.graphics.clear(TRANSPARENT_COLOR)
		for file = 1, 8 do
			for rank = 1, 8 do
				piece.draw(self.pieceMatrix[file][rank], file, rank)
			end
		end
	end)
end

function board:updateHighlightCanvas()
	self.highlightCanvas:renderTo(function()
		love.graphics.clear(TRANSPARENT_COLOR)
		for file = 1, 8 do
			for rank = 1, 8 do
				love.graphics.setColor(self:stateColor(file, rank))
				love.graphics.rectangle(
					"fill",
					(file-1)*SQUARE_SIZE,
					(rank-1)*SQUARE_SIZE,
					SQUARE_SIZE,
					SQUARE_SIZE)
			end
		end
		love.graphics.setColor(DEFAULT_COLOR)
	end)
end

-- Initialize Board module.
function board:initialize()	
	self:updateBackgroundCanvas()
	self:updatePieceCanvas()
	self:updateHighlightCanvas()
end

function board:draw()
	love.graphics.draw(self.backgroundCanvas, 0, 0)
	love.graphics.draw(self.highlightCanvas, 0, 0)
	love.graphics.draw(self.pieceCanvas, 0, 0)
end
