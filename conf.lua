require "source/constants"

function love.conf(t)
    t.window.title = "Chess"
    t.window.width = BOARD_SIZE+BAR_SIZE
    t.window.height = BOARD_SIZE
    -- t.window.icon = "resource/icon.png"

    t.console = DEBUG
end
