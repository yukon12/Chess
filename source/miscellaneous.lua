miscellaneous = {nil}

miscellaneous.turn = "white"

function miscellaneous:switchTurn()
	if self.turn == "white" then self.turn = "black"
	else self.turn = "white" end
end
