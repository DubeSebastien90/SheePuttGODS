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
}