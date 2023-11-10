resources = {nil}

resources.texturePiece = {nil}

resources.smallFont = nil

resources.bigFont = nil

-- Load resources.
function resources:initialize()
	-- Load piece textures.
	for i, type in pairs(PIECE_TYPE) do
		self.texturePiece[type] = love.graphics.newImage("resources/"..type..".png")
	end

	self.smallFont = love.graphics.newFont("resources/Silkscreen-Regular.ttf", SMALL_FONT_SIZE)
	self.bigFont = love.graphics.newFont("resources/Silkscreen-Regular.ttf", BIG_FONT_SIZE)
end
