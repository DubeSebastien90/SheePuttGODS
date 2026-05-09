var _offset = 0;
var _index = 0
if (on_water && !in_air) {
	_offset = water_offset;
	_index = 1
}
if (mort){
	_index = 2
}
draw_sprite(sprite_index, _index, x, y + _offset - (z * 2));