nbMuttonArrived = 0
with(obj_mutton){
	if isInWinnableTile(){
		other.nbMuttonArrived += 1
	}
}

if nbMuttonArrived >= obj_grid.muttons_for_win{
	winCooldown -= 1
	if winCooldown < 0{
		canEnd = true
	} else {
		canEnd = false
	}
} else{
	winCooldown = timeToWin	
	canEnd = false
}

if keyboard_check_pressed(ord("0")){
	changeMenuState(0)
}

if keyboard_check_pressed(ord("1")){
	changeMenuState(1)
}

if canEnd {
	win_button.show = true
} else {
	win_button.show = false
}