var _offset = 0;
var _index = 0;
if (mort){
	_index = 2
}
if !in_air && on_water{
	_index = 1
}

if !on_water || in_air{
	draw_sprite_ext(sprite_index,5,x,y,1,1,0,c_white,0.3)
}


if !in_air{
	draw_sprite_ext(sprite_index, _index, x, y + _offset - (z * 2),_side,1,rot,c_white,1);
} else {
	draw_sprite_ext(spr_mutton_air, _spin_index%12, x, y + _offset - (z * 2),spin_side,1,rot,c_white,1);
}

