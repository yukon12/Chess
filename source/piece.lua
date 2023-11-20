piece = {nil}

function piece.type(index)
	if index < 1 or index > 12 then return nil end
	return PIECE_TYPE[((index-1)%6)+1]
end

function piece.color(index)
	if index < 1 or index > 12 then return nil end
	return COLOR[math.ceil(index/6)]
end

function piece.draw(index, file, rank)
	local color = piece.color(index)
	if color == "white" then
		love.graphics.setColor(LIGHT_COLOR)
	elseif color == "black" then
		love.graphics.setColor(DARK_COLOR)
	else
		return
	end

	love.graphics.draw(	
		resources.texturePiece[piece.type(index)],
		(file-1)*SQUARE_SIZE,
		(rank-1)*SQUARE_SIZE,
		0, TEXTURE_SCALE, TEXTURE_SCALE, TEXTURE_OFFSET, TEXTURE_OFFSET
	)

	love.graphics.setColor(DEFAULT_COLOR)
end

function piece.linearMove(file, rank, color, fileDirection, rankDirection, matrix)
	local currentFile
	local currentRank
	for i = 1, 7 do
		currentFile = file+i*fileDirection
		currentRank = rank+i*rankDirection
		if not board:isOnBoard(currentFile, currentRank) then return end
		if board:isPiece(currentFile, currentRank) then
			if board:squareColor(currentFile, currentRank) == miscellaneous:oppositeColor(color) then
				matrix[currentFile][currentRank] = true
			end
			return
		else
			matrix[currentFile][currentRank] = true
		end
	end
end

function piece.pointwiseMove(file, rank, color, fileDirection, rankDirection, matrix)
	if #fileDirection ~= #rankDirection then return false end
	local points = #fileDirection
	local currentFile
	local currentRank
	for i = 1, points do
		currentFile = file+fileDirection[i]
		currentRank = rank+rankDirection[i]
		if board:isOnBoard(currentFile, currentRank) then
			if board:squareColor(currentFile, currentRank) ~= color then
				matrix[currentFile][currentRank] = true
			end
		end
	end
end

function piece.pawnMove(file, rank, color)
	local result = GENERATE_MATRIX(false)
	local front = (color=="white") and -1 or 1
	local initialRank = (color=="white") and 7 or 2

	if not board:isPiece(file, rank+front) then
		result[file][rank+front] = true
		if rank == initialRank and not board:isPiece(file, rank+2*front) then
			result[file][rank+2*front] = true
		end
	end

	if board:isOnBoard(file+1, rank+front) and board:squareColor(file+1, rank+front) == miscellaneous:oppositeColor(color) then
		result[file+1][rank+front] = true
	end

	if board:isOnBoard(file-1, rank+front) and board:squareColor(file-1, rank+front) == miscellaneous:oppositeColor(color) then
		result[file-1][rank+front] = true
	end

	if board.enPassantMatrixLeft[file][rank] then
		result[file-1][rank+front] = true
	end

	if board.enPassantMatrixRight[file][rank] then
		result[file+1][rank+front] = true
	end

	return result
end

function piece.rookMove(file, rank, color)
	local result = GENERATE_MATRIX(false)
	piece.linearMove(file, rank, color, 0, -1, result)
	piece.linearMove(file, rank, color, 0, 1, result)
	piece.linearMove(file, rank, color, -1, 0, result)
	piece.linearMove(file, rank, color, 1, 0, result)
	return result
end

function piece.knightMove(file, rank, color)
	local result = GENERATE_MATRIX(false)
	local fileDirection = {-2, -2, -1, -1, 1, 1, 2, 2}
	local rankDirection = {-1, 1, -2, 2, -2, 2, -1, 1}
	piece.pointwiseMove(file, rank, color, fileDirection, rankDirection, result)
	return result
end

function piece.bishopMove(file, rank, color)
	local result = GENERATE_MATRIX(false)
	piece.linearMove(file, rank, color, 1, 1, result)
	piece.linearMove(file, rank, color, -1, 1, result)
	piece.linearMove(file, rank, color, 1, -1, result)
	piece.linearMove(file, rank, color, -1, -1, result)
	return result
end

function piece.queenMove(file, rank, color)
	local result = GENERATE_MATRIX(false)
	piece.linearMove(file, rank, color, 0, -1, result)
	piece.linearMove(file, rank, color, 0, 1, result)
	piece.linearMove(file, rank, color, -1, 0, result)
	piece.linearMove(file, rank, color, 1, 0, result)
	piece.linearMove(file, rank, color, 1, 1, result)
	piece.linearMove(file, rank, color, -1, 1, result)
	piece.linearMove(file, rank, color, 1, -1, result)
	piece.linearMove(file, rank, color, -1, -1, result)
	return result
end

function piece.kingMove(file, rank, color)
	local result = GENERATE_MATRIX(false)
	local fileDirection = {-1, -1, -1, 0, 0, 1, 1, 1}
	local rankDirection = {-1, 0, 1, -1, 1, -1, 0, 1}
	piece.pointwiseMove(file, rank, color, fileDirection, rankDirection, result)
	return result
end

piece.moveFunction = {
	pawn = piece.pawnMove,
	rook = piece.rookMove,
	knight = piece.knightMove,
	bishop = piece.bishopMove,
	queen = piece.queenMove,
	king = piece.kingMove
}

function piece.getAvailableMoves(index, file, rank)
	local type = piece.type(index)
	local color = piece.color(index)
	if type == nil then
		return GENERATE_MATRIX(false)
	else
		return piece.moveFunction[type](file, rank, color)
	end
end
