nbMuttonArrived = 0

restart_button = instance_create_layer(35,105,"dessus",obj_button_restart)
restart_button._alpha = 0
win_button = instance_create_layer(30*3 + 10,105,"dessus",obj_button_end)
win_button._alpha = 0
win_button.show = false
menu_button = instance_create_layer(28*3 + 5,35,"dessus",obj_button_menu)
menu_button._alpha = 0


play_button = instance_create_layer(room_width/2,room_height*4/5,"dessus",obj_button_play)
prev_button = instance_create_layer(room_width/2 - 220,room_height*4/5 + 20,"dessus",obj_button_prev)
prev_button._alpha = 0
prev_button.show = false
next_button = instance_create_layer(room_width/2 + 220,room_height*4/5 + 20,"dessus",obj_button_next)
next_button._alpha = 0
next_button.show = false

timeToWin = 30
winCooldown = timeToWin

canEnd = false

menuState = -1

function changeMenuState(_state){
	if _state == 0{
		restart_button.show = true
		menu_button.show = true
		play_button.show = false
		prev_button.show = false
		next_button.show = false
	}
	if _state == 1{
		restart_button.show = false
		menu_button.show = false
		play_button.show = true
	}
	
	menuState = _state
}

changeMenuState(1)

sliding = 0

levelFinished = -1

function draw_mini_level(_level_index, _xPos, _yPos) {
	var _cond = global.conditions[_level_index]
	
	// Title centered on top
	draw_set_halign(fa_center)
	draw_set_valign(fa_top)
	draw_set_color(c_white)
	draw_text(_xPos, _yPos, _cond.level_title)
	
	// Stars centered underneath
	var _star_spacing = sprite_get_width(spr_star) + 4
	var _star_y = _yPos + string_height(_cond.level_title) + 4
	var _star_start_x = _xPos - _star_spacing
	
	var _stars = [_cond.first_star, _cond.second_star, _cond.third_star]
	for (var i = 0; i < 3; i++) {
		var _frame = 0
		if (!is_undefined(_stars[i]) && _stars[i].collected) _frame = 1
		draw_sprite(spr_star, _frame, _star_start_x + i * _star_spacing, _star_y)
	}
	
	// Reset alignment
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}

function draw_detailed_level(_level_index, _xPos, _yPos) {
	var _cond = global.conditions[_level_index]
	
	// Title centered on top
	draw_set_halign(fa_center)
	draw_set_valign(fa_top)
	draw_set_color(c_white)
	draw_text(_xPos, _yPos, _cond.level_title)
	
	// Stars listed below with descriptions
	draw_set_halign(fa_left)
	draw_set_valign(fa_middle)
	
	var _star_size = sprite_get_height(spr_star)
	var _line_height = max(_star_size, string_height("A")) + 6
	var _list_start_y = _yPos + string_height(_cond.level_title) + 10
	
	var _stars = [_cond.first_star, _cond.second_star, _cond.third_star]
	for (var i = 0; i < 3; i++) {
		var _star = _stars[i]
		if (is_undefined(_star)) continue
		
		var _line_y = _list_start_y + i * _line_height
		var _frame = _star.collected ? 1 : 0
		
		// Star icon on the left
		draw_sprite(spr_star, _frame, _xPos, _line_y)
		
		// Description text to the right of the star
		draw_text(_xPos + _star_size + 6, _line_y, _star.description)
	}
	
	// Reset alignment
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}

isAnimating = false
frame = 0
maxFrames = 12

function startAnimation(){
	if !isAnimating{
		isAnimating = true
		frame = 0
	}
}