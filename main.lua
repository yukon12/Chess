require "source/constants"
require "source/debug"
require "source/resources"
require "source/piece"
require "source/board"

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	resources:initialize()
	board:initialize()	
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()	
	end
end

function love.update()

end

function love.draw()
	board:draw()
end
