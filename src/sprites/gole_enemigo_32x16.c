#include "gole_enemigo_32x16.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Tile spr_muerte_enemigo_0: 20x32 pixels, 10x32 bytes.
const u8 spr_muerte_enemigo_0[10 * 32] = {
	0x00, 0x00, 0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x2c, 0x0c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x2c, 0x0c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x3c, 0x0c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x1c, 0x2c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x0c, 0x2c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x14, 0x28, 0x1c, 0x0c, 0x2c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x14, 0x00, 0x1c, 0x0c, 0x0c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x28, 0x14, 0x0c, 0x3c, 0x3c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x28, 0x3c, 0x2c, 0x3c, 0x0c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x3c, 0x2c, 0x1c, 0x2c, 0x0c, 0x08, 0x00, 0x00,
	0x14, 0x14, 0x3c, 0x3c, 0x1c, 0x3c, 0x0c, 0x08, 0x00, 0x00,
	0x14, 0x14, 0x3c, 0x3c, 0x1c, 0x1c, 0x0c, 0x08, 0x00, 0x00,
	0x14, 0x14, 0x3c, 0x3c, 0x1c, 0x1c, 0x0c, 0x08, 0x00, 0x00,
	0x14, 0x14, 0x3c, 0x3c, 0x1c, 0x3c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x3c, 0x2c, 0x1c, 0x2c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x28, 0x3c, 0x2c, 0x3c, 0x1c, 0x2c, 0x08, 0x00, 0x00,
	0x00, 0x28, 0x14, 0x0c, 0x3c, 0x3c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x14, 0x00, 0x1c, 0x1c, 0x0c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x14, 0x28, 0x1c, 0x0c, 0x2c, 0x0c, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x0c, 0x2c, 0x3c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x0c, 0x3c, 0x1c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x1c, 0x2c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x0c, 0x0c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x0c, 0x0c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00
};

// Tile spr_muerte_enemigo_1: 20x32 pixels, 10x32 bytes.
const u8 spr_muerte_enemigo_1[10 * 32] = {
	0x00, 0x00, 0x00, 0x00, 0x04, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x08, 0x08, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x2c, 0x08, 0x04, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x14, 0x04, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x28, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x14, 0x00, 0x00, 0x0c, 0x00, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x14, 0x00, 0x00, 0x28, 0x00, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x28, 0x14, 0x04, 0x00, 0x04, 0x08, 0x00, 0x00,
	0x00, 0x28, 0x00, 0x08, 0x28, 0x28, 0x08, 0x08, 0x00, 0x00,
	0x14, 0x3c, 0x14, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x14, 0x3c, 0x00, 0x28, 0x08, 0x28, 0x08, 0x08, 0x00, 0x00,
	0x3c, 0x3c, 0x28, 0x00, 0x00, 0x00, 0x04, 0x08, 0x00, 0x00,
	0x3c, 0x3c, 0x28, 0x14, 0x08, 0x1c, 0x0c, 0x00, 0x00, 0x00,
	0x3c, 0x3c, 0x28, 0x28, 0x00, 0x14, 0x00, 0x08, 0x00, 0x00,
	0x3c, 0x3c, 0x28, 0x00, 0x00, 0x28, 0x04, 0x08, 0x00, 0x00,
	0x14, 0x3c, 0x00, 0x28, 0x08, 0x2c, 0x04, 0x00, 0x00, 0x00,
	0x14, 0x3c, 0x14, 0x04, 0x00, 0x1c, 0x04, 0x00, 0x00, 0x00,
	0x00, 0x28, 0x00, 0x00, 0x14, 0x00, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x28, 0x00, 0x14, 0x08, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x14, 0x00, 0x28, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x28, 0x00, 0x28, 0x28, 0x04, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x14, 0x14, 0x04, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x14, 0x00, 0x14, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x04, 0x04, 0x04, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00
};

// Tile spr_muerte_enemigo_2: 20x32 pixels, 10x32 bytes.
const u8 spr_muerte_enemigo_2[10 * 32] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

