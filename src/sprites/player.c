#include "player.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Tile spr_player_0: 16x32 pixels, 8x32 bytes.
const u8 spr_player_0[8 * 32] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x04, 0x39, 0x33, 0x33, 0x26, 0x00, 0x00,
	0x00, 0x1c, 0x33, 0x26, 0x0c, 0x19, 0x08, 0x00,
	0x04, 0x39, 0x33, 0x49, 0xc3, 0x86, 0x26, 0x00,
	0x04, 0x39, 0x26, 0xc3, 0xc3, 0xc3, 0x19, 0x08,
	0x1c, 0x39, 0x26, 0xc3, 0xc3, 0xc3, 0x19, 0x08,
	0x1c, 0x3c, 0x26, 0xcc, 0xc3, 0xcc, 0x19, 0x08,
	0x1c, 0x1c, 0x26, 0xc6, 0xc3, 0xc6, 0x19, 0x08,
	0x1c, 0x1c, 0x26, 0xc3, 0xc3, 0xc3, 0x19, 0x08,
	0x04, 0x1c, 0x39, 0x49, 0xc6, 0xc3, 0x1c, 0x08,
	0x00, 0x04, 0x3c, 0x2c, 0xc3, 0x86, 0x3c, 0x08,
	0x00, 0x00, 0x0c, 0x3c, 0x0c, 0x1c, 0x3c, 0x08,
	0x00, 0x04, 0x3c, 0x39, 0x33, 0x33, 0x2c, 0x00,
	0x00, 0x1c, 0x33, 0x33, 0x33, 0x33, 0x36, 0x08,
	0x00, 0x1c, 0x33, 0x33, 0x33, 0x33, 0x36, 0x08,
	0x00, 0x19, 0x33, 0x33, 0x33, 0x33, 0x36, 0x08,
	0x00, 0x19, 0x33, 0x33, 0x33, 0x33, 0x33, 0x08,
	0x04, 0x39, 0x33, 0x33, 0x33, 0x33, 0x33, 0x08,
	0x04, 0x39, 0x33, 0x33, 0x36, 0x33, 0x33, 0x2c,
	0x04, 0x39, 0x33, 0x33, 0x36, 0x33, 0x33, 0x2c,
	0x04, 0x39, 0x33, 0x33, 0x2c, 0x39, 0x36, 0x2c,
	0x1c, 0x3c, 0x36, 0x36, 0x2c, 0x3c, 0x36, 0x2c,
	0x1c, 0x3c, 0x39, 0x3c, 0x2c, 0x1c, 0x3c, 0x2c,
	0x1c, 0x1c, 0x3c, 0x3c, 0x08, 0x1c, 0x2c, 0x2c,
	0x04, 0x1c, 0x1c, 0x2c, 0x08, 0x04, 0x3c, 0x08,
	0x00, 0x0c, 0x04, 0x0c, 0x00, 0x04, 0x0c, 0x00,
	0x00, 0x00, 0x41, 0x82, 0x00, 0x00, 0x82, 0x00,
	0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x82, 0x00,
	0x00, 0x00, 0x00, 0x82, 0x00, 0x00, 0x82, 0x00
};

// Tile spr_player_1: 16x32 pixels, 8x32 bytes.
const u8 spr_player_1[8 * 32] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x04, 0x39, 0x33, 0x33, 0x26, 0x00, 0x00,
	0x00, 0x1c, 0x33, 0x26, 0x0c, 0x19, 0x08, 0x00,
	0x04, 0x39, 0x33, 0x49, 0xc3, 0x86, 0x26, 0x00,
	0x04, 0x39, 0x26, 0xc3, 0xc3, 0xc3, 0x19, 0x08,
	0x1c, 0x39, 0x26, 0xc3, 0xc3, 0xc3, 0x19, 0x08,
	0x1c, 0x3c, 0x26, 0xc3, 0xc3, 0xc3, 0x19, 0x08,
	0x1c, 0x1c, 0x26, 0xc6, 0xc3, 0xc6, 0x19, 0x08,
	0x1c, 0x1c, 0x26, 0xc3, 0xc3, 0xc3, 0x19, 0x08,
	0x04, 0x1c, 0x39, 0x49, 0xc6, 0xc3, 0x1c, 0x08,
	0x00, 0x04, 0x3c, 0x2c, 0xc3, 0x86, 0x3c, 0x08,
	0x00, 0x00, 0x0c, 0x3c, 0x0c, 0x1c, 0x3c, 0x08,
	0x00, 0x04, 0x3c, 0x39, 0x33, 0x33, 0x2c, 0x00,
	0x00, 0x1c, 0x33, 0x33, 0x33, 0x33, 0x36, 0x08,
	0x00, 0x1c, 0x33, 0x33, 0x33, 0x33, 0x36, 0x08,
	0x00, 0x19, 0x33, 0x33, 0x33, 0x33, 0x36, 0x08,
	0x00, 0x19, 0x33, 0x33, 0x33, 0x33, 0x33, 0x08,
	0x04, 0x39, 0x33, 0x33, 0x33, 0x33, 0x33, 0x08,
	0x04, 0x39, 0x33, 0x33, 0x36, 0x33, 0x33, 0x2c,
	0x04, 0x39, 0x33, 0x33, 0x36, 0x33, 0x33, 0x2c,
	0x04, 0x39, 0x33, 0x33, 0x2c, 0x39, 0x36, 0x2c,
	0x1c, 0x3c, 0x36, 0x36, 0x2c, 0x3c, 0x36, 0x2c,
	0x1c, 0x3c, 0x39, 0x3c, 0x2c, 0x1c, 0x3c, 0x2c,
	0x1c, 0x1c, 0x3c, 0x3c, 0x08, 0x1c, 0x2c, 0x2c,
	0x04, 0x1c, 0x1c, 0x2c, 0x08, 0x04, 0x3c, 0x08,
	0x00, 0x0c, 0x04, 0x0c, 0x00, 0x04, 0x0c, 0x00,
	0x00, 0x00, 0x00, 0x41, 0x00, 0x00, 0x82, 0x00,
	0x00, 0x00, 0x00, 0x41, 0x00, 0x00, 0x82, 0x00,
	0x00, 0x00, 0x00, 0x82, 0x00, 0x41, 0x00, 0x00
};

