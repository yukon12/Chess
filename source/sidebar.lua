sidebar = {nil}

sidebar.canvas = love.graphics.newCanvas(SIDEBAR_SIZE, BOARD_SIZE)

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
	end)
end

function sidebar:initialize()
	self:updateCanvas()
end

function sidebar:draw()
	love.graphics.draw(self.canvas, BOARD_SIZE, 0)
end
