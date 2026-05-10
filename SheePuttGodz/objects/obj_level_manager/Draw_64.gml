if menuState != 0{
	draw_set_font(fnt_pixel)
	
	var _idx = obj_grid.level_index
	var _total = array_length(global.conditions)
	var _spacing = 500
	var _cx = room_width / 2
	var _cy = room_height / 2
	
	// Draw all mini levels, skipping the current one
	for (var i = 0; i < _total; i++) {
		if (i == _idx) continue
		if (global.conditions[i].unlocked == false) continue
		var _offset = (i - sliding) * _spacing
		draw_mini_level(i, _cx + _offset, _cy)
	}
	
	// Draw current level detailed in the center, on top
	var _detailed_offset = (_idx - sliding) * _spacing
	draw_detailed_level(_idx, _cx + _detailed_offset, _cy)
} else {
	draw_sprite_ext(spr_mutton,7,30,160,3,3,0,c_white,1)
	if isAnimating{
		draw_sprite_ext(spr_mutton_air,frame,30,162,3,3,0,c_white,1)
	}else{
		draw_sprite_ext(spr_mutton,0,30,162,3,3,0,c_white,1)
	}
	draw_set_halign(fa_left)
	draw_set_valign(fa_center)
	draw_text_transformed(65,160,string(nbMuttonArrived)+"/"+string(global.conditions[obj_grid.level_index].muttons_for_win ),1,1,0)
}