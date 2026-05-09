if is_hovered(){
	size = 1+sin(temps)*0.05
	temps += 0.1
	if mouse_check_button_pressed(mb_left) && show {
		on_clicked()
	}
} else {
	size = lerp(size,1,0.1)
	temps = 0
}

