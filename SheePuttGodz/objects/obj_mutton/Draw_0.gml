var _offset = 0;
if (on_water && !in_air) {
	_offset = water_offset;
}
draw_sprite(sprite_index, image_index, x, y + _offset - (z * 2));