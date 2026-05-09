nbMuttonArrived = 0
with(obj_mutton){
	if isInWinnableTile(){
		other.nbMuttonArrived += 1
	}
}

if nbMuttonArrived >= obj_grid.muttons_for_win{
	obj_grid.change_level(obj_grid.level_index+1)
}

if keyboard_check_pressed(ord("0")){
	changeMenuState(0)
}

if keyboard_check_pressed(ord("1")){
	changeMenuState(1)
}