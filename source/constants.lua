-- #FEFAE0
LIGHT_COLOR = {1.00, 0.98, 0.88}
-- #4C4B43
DARK_COLOR = {0.30, 0.29, 0.26}
-- #FFFFFF
DEFAULT_COLOR = {1.00, 1.00, 1.00}

DEBUG = false

SQUARE_SIZE = 64
BOARD_SIZE = 8*SQUARE_SIZE
BAR_SIZE = 4*SQUARE_SIZE

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

PIECE_TYPE = {"pawn", "rook", "knight", "bishop", "queen", "king"}

COLOR = {"white", "black"}

TEXTURE_SCALE = 4
TEXTURE_PIXELS = 12
TEXTURE_SIZE = TEXTURE_SCALE*TEXTURE_PIXELS
TEXTURE_OFFSET = -(SQUARE_SIZE-TEXTURE_SIZE)/(2*TEXTURE_SCALE)
