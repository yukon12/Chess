TITLE = "Chess"
VERSION = "1.0"

HIGHLIGHT_FACTOR = 0.50

-- #FEFAE0
LIGHT_COLOR = {1.00, 0.98, 0.88}
-- #4C4B43
DARK_COLOR = {0.30, 0.29, 0.26}
-- #FFFFFF
DEFAULT_COLOR = {1.00, 1.00, 1.00}
-- TRANSPARENT
TRANSPARENT_COLOR = {0.00, 0.00, 0.00, 0.00}
-- #000000 (HIGHLIGHT)
BLACK_COLOR = {0.00, 0.00, 0.00, HIGHLIGHT_FACTOR}
-- #FF00FF (HIGHLIGHT)
MAGENTA_COLOR = {1.00, 0.00, 1.00, HIGHLIGHT_FACTOR}
-- #FFFF00 (HIGHLIGHT)
YELLOW_COLOR = {1.00, 1.00, 0.00, HIGHLIGHT_FACTOR}
-- #00FFFF (HIGHLIGHT)
CYAN_COLOR = {0.00, 1.00, 1.00, HIGHLIGHT_FACTOR}
-- #000000
SIDEBAR_COLOR = {0.00, 0.00, 0.00}

DEBUG = true

SQUARE_SIZE = 64
BOARD_SIZE = 8*SQUARE_SIZE
SIDEBAR_SIZE = 4*SQUARE_SIZE

DEFAULT_PIECE_PLACEMENT = {
	{8, 7, 0, 0, 0, 0, 1, 2},
	{9, 7, 0, 0, 0, 0, 1, 3},
	{10, 7, 0, 0, 0, 0, 1, 4},
	{11, 7, 0, 0, 0, 0, 1, 5},
	{12, 7, 0, 0, 0, 0, 1, 6},
	{10, 7, 0, 0, 0, 0, 1, 4},
	{9, 7, 0, 0, 0, 0, 1, 3},
	{8, 7, 0, 0, 0, 0, 1, 2}
}

function GENERATE_MATRIX(value)
	local result = {nil}
	for i = 1, 8 do
		result[i] = {nil}
		for j = 1, 8 do
			result[i][j] = value
		end
	end
	return result
end

function COPY_MATRIX(source)
	local result = {nil}
	for i = 1, 8 do
		result[i] = {nil}
		for j = 1, 8 do
			result[i][j] = source[i][j]
		end
	end
	return result
end	

PIECE_TYPE = {"pawn", "rook", "knight", "bishop", "queen", "king"}

COLOR = {"white", "black"}

TEXTURE_SCALE = 4
TEXTURE_PIXELS = 12
TEXTURE_SIZE = TEXTURE_SCALE*TEXTURE_PIXELS
TEXTURE_OFFSET = -(SQUARE_SIZE-TEXTURE_SIZE)/(2*TEXTURE_SCALE)

SMALL_FONT_SIZE = 20
BIG_FONT_SIZE = 40
