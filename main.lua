require "source/constants"
require "source/miscellaneous"
require "source/interface"
require "source/debug"
require "source/resources"
require "source/piece"
require "source/sidebar"
require "source/board"

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	resources:initialize()
	board:initialize()	
	sidebar:initialize()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()	
	end
end

function love.mousepressed(x, y, button)
	if button == 1 then
		interface:click(x, y)
	end
end

function love.update()

end

function love.draw()
	board:draw()
	sidebar:draw()
end
