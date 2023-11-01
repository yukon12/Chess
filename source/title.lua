function Title()
    return {
        smallFont = love.graphics.newFont(64),
        bigFont = love.graphics.newFont(128),
        --hover keeps information on which button does the cursor hovers
        hover = {play = false, exit = false},
        --mp is mouse position
        mp = {x = 0, y = 0},
        --buttonDown tells if left mouse button is down
        --buttonPressed tells if left mouse button was pressed during this frame
        buttonDown = false,
        buttonPressed = false,
        update = function(self)
            --if the button was not down on the last frame but it is now, then the buttonPressed is true
            self.buttonPressed = false
            if not self.buttonDown and love.mouse.isDown(1) then
                self.buttonPressed = true
            end
            self.buttonDown = love.mouse.isDown(1)

            --checks if the cursor hovers on any of the buttons
            self.mp.x, self.mp.y = love.mouse.getPosition()
            self.hover.play = false
            self.hover.exit = false
            if self.mp.x > 200 and self.mp.x < 600 and self.mp.y > 300 and self.mp.y < 400 then
                self.hover.play = true
                if self.buttonPressed then
                    modeNumber = 1
                end
            elseif self.mp.x > 200 and self.mp.x < 600 and self.mp.y > 450 and self.mp.y < 550 then
                self.hover.exit = true
                if self.buttonPressed then
                    love.event.quit()
                end
            end
        end,
        draw = function(self)
            --print "Chess" texture
            love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
            love.graphics.printf("Chess", self.bigFont, love.math.newTransform(200, 100), 400, "center")

            --print "Play" button
            if self.hover.play then
                love.graphics.setColor(0.5, 0.5, 1.0, 1.0)
                love.graphics.rectangle("fill", 200, 300, 400, 100)
                love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
                love.graphics.printf("play", self.smallFont, love.math.newTransform(200, 318), 400, "center")
            else
                love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
                love.graphics.rectangle("fill", 200, 300, 400, 100)
                love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
                love.graphics.printf("play", self.smallFont, love.math.newTransform(200, 318), 400, "center")
            end

            --print "Exit" button
            if self.hover.exit then
                love.graphics.setColor(0.5, 0.5, 1.0, 1.0)
                love.graphics.rectangle("fill", 200, 450, 400, 100)
                love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
                love.graphics.printf("exit", self.smallFont, love.math.newTransform(200, 468), 400, "center")
            else
                love.graphics.setColor(1.0, 1.0, 1.0, 1.0)
                love.graphics.rectangle("fill", 200, 450, 400, 100)
                love.graphics.setColor(0.0, 0.0, 0.0, 1.0)
                love.graphics.printf("exit", self.smallFont, love.math.newTransform(200, 468), 400, "center")
            end
        end
    }
end