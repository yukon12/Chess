miscellaneous = {nil}

miscellaneous.turn = "white"

function miscellaneous:switchTurn()
	if self.turn == "white" then self.turn = "black"
	else self.turn = "white" end
	sidebar:updateCanvas()
end

function miscellaneous:oppositeColor(color)
	if color == "white" then return "black" end
	if color == "black" then return "white" end
	return nil
end
