var _prevArrived = nbMuttonArrived
nbMuttonArrived = 0
nbMuttonFoutus = 0
with(obj_mutton){
	if isInWinnableTile(){
		other.nbMuttonArrived += 1
	}
	if isCompletementFoutu(){
		other.nbMuttonFoutus += 1
	}
}

if global.conditions[obj_grid.level_index].muttons_total - nbMuttonFoutus <  global.conditions[obj_grid.level_index].muttons_for_win{
	isLoosing = true
} else {
	isLoosing = false
}

if _prevArrived < nbMuttonArrived{
	startAnimation()
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

if canEnd && menuState == 0 {
	win_button.show = true
} else {
	win_button.show = false
}

if obj_grid.level_index == 0{
	prev_button.show = false
} else if menuState== 1{
	prev_button.show = true
}

if obj_grid.level_index == obj_grid.nbLevels - 1 || global.conditions[obj_grid.level_index+1].unlocked == false {
	next_button.show = false
} else if menuState == 1 && global.conditions[obj_grid.level_index+1].unlocked == true{
	next_button.show = true
}

if isAnimating{
	frame += obj_mutton.spin_speed
	if frame > maxFrames{
		isAnimating = false
	}
}

sliding = lerp(sliding, obj_grid.level_index, 0.15)