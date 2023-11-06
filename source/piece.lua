piece = {nil}

function piece.type(index)
	if index < 1 or index > 12 then return nil end
	return PIECE_TYPE[((index-1)%6)+1]
end

function piece.color(index)
	if index < 1 or index > 12 then return nil end
	return COLOR[math.ceil(index/6)]
end

function piece.draw(index, column, file)
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
		(column-1)*SQUARE_SIZE,
		(file-1)*SQUARE_SIZE,
		0, TEXTURE_SCALE, TEXTURE_SCALE, TEXTURE_OFFSET, TEXTURE_OFFSET
	)

	love.graphics.setColor(DEFAULT_COLOR)
end
