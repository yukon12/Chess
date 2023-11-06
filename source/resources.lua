resources = {nil}

resources.texturePiece = {nil}

-- Load resources.
function resources:initialize()
	-- Load piece textures.
	for i, type in pairs(PIECE_TYPE) do
		self.texturePiece[type] = love.graphics.newImage("resources/"..type..".png")
	end
end
