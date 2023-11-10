require "source/constants"

function love.conf(t)
    t.window.title = TITLE
    t.window.width = BOARD_SIZE+SIDEBAR_SIZE
    t.window.height = BOARD_SIZE
    -- t.window.icon = "resource/icon.png"
    t.console = DEBUG
end
