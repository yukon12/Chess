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
		if sidebar.buttonHover[1] then sidebar:undo() end
		if sidebar.buttonHover[2] then sidebar:restart() end
		if sidebar.buttonHover[3] then sidebar:exit() end
	end
end

function love.update()
	local x, y = love.mouse.getPosition()
	sidebar.buttonHover = {false, false, false}

	if x > BOARD_SIZE+60 and x < BOARD_SIZE+SIDEBAR_SIZE-60 then
		if y > 400 and y < 440 then
			sidebar.buttonHover[1] = true
		elseif y > 440 and y < 480 then
			sidebar.buttonHover[2] = true
		elseif y > 480 and y < 520 then
			sidebar.buttonHover[3] = true
		end
	end

	sidebar:updateCanvas()
end

function love.draw()
	board:draw()
	sidebar:draw()
end
