interface = {nil}

-- Selected square.
interface.selected = nil

-- Function checks if any square is selected.
function interface:isSelected()
	return self.selected ~= nil
end

function interface:click(x, y)
	local file = math.ceil(x/SQUARE_SIZE)
	local rank = math.ceil(y/SQUARE_SIZE)
	if file < 1 or file > 8 then return end
	if rank < 1 or rank > 8 then return end
	self:select(file, rank)
end

function interface:select(file, rank)
	if board:isAvailable(file, rank) then
		board:move(self.selected.file, self.selected.rank, file, rank)
		board:updatePieceCanvas()
	end
	board:updateAvailableMoves(file, rank)
	board:updateStateMatrix(file, rank)
	board:updateHighlightCanvas()
	self.selected = {file = file, rank = rank}
end
