require "source/constants"
require "source/miscellaneous"
require "source/interface"
require "source/debug"
require "source/resources"
require "source/piece"
require "source/board"

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	-- We want line to be one pixel wide compared to our textures.
	love.graphics.setLineWidth(TEXTURE_SCALE)

	resources:initialize()
	board:initialize()	
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()	
	end
end

function love.mousepressed(x, y, button)
	debug.log("click")
	if button == 1 then
		interface:click(x, y)
	end
end

function love.update()

end

function love.draw()
	board:draw()
end
