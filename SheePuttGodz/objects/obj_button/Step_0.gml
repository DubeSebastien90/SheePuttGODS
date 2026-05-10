if is_hovered(){
	size = 1+sin(temps)*0.05
	temps += 0.1
	if mouse_check_button_released(mb_left) && show {
		on_clicked()
		obj_son.play_sound(snd_pop,0.2)
	}
} else {
	size = lerp(size,1,0.1)
	temps = 0
}

if show {
	_alpha = lerp(_alpha,1,0.1)
} else {
	_alpha = lerp(_alpha,0,0.1)
}

