nbMuttonArrived = 0

restart_button = instance_create_layer(35,35,"dessus",obj_button_restart)
restart_button._alpha = 0
win_button = instance_create_layer(30*3 + 10,35,"dessus",obj_button_end)
win_button._alpha = 0
menu_button = instance_create_layer(room_width/2,room_height*3/4,"dessus",obj_button_menu)

timeToWin = 30
winCooldown = timeToWin

canEnd = false

menuState = -1

function changeMenuState(_state){
	if _state == 0{
		restart_button.show = true
		menu_button.show = false
	}
	if _state == 1{
		restart_button.show = false
		menu_button.show = true
	}
	
	menuState = _state
}

changeMenuState(1)