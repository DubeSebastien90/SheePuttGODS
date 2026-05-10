var _offset = 0;
var _index = 0;
if (mort){
	_index = 2
}

if !on_water || in_air{
	draw_sprite_ext(sprite_index,5,x,y,1,1,0,c_white,0.3)
}

draw_sprite_ext(sprite_index, _index, x, y + _offset - (z * 2),1,1,rot,c_white,1);