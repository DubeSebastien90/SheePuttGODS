if obj_level_manager.isLoosing{
	_temps += 6
	rot = dsin(_temps)*10
} else{
	rot = lerp(rot,0,0.1)
	_temps = 0
}
draw_sprite_ext(sprite_index,is_hovered(), x, y, size*_size, size*_size, rot, c_white, _alpha)

