nbStomps = 0
timer = 0

function resetMetrics(){
	nbStomps = 0
	timer = 0
	with(obj_bumper){
		isBounced = false
	}
}



function submitStar(level, num){
	if num == 1 {
		if global.conditions[level].first_star.collected = false{
			obj_son.play_sound(snd_yay,0)
		}
		global.conditions[level].first_star.collected = true
	}
	if num == 2 {
		if global.conditions[level].second_star.collected = false{
			obj_son.play_sound(snd_yay,0)
		}
		global.conditions[level].second_star.collected = true
	}
	if num == 3 {
		if global.conditions[level].third_star.collected = false{
			obj_son.play_sound(snd_yay,0)
		}
		global.conditions[level].third_star.collected = true
	}
}

function checkLevelTime(){
	if obj_grid.level_index == 1{
		var nbMort = 0
		with(obj_mutton){
			if mort {
				nbMort += 1
			}
		}
		if nbMort == 3{
			submitStar(obj_grid.level_index,3)
		}
		
	} else if obj_grid.level_index == 3{
		var _tile = noone
		with(obj_mutton){
			if _tile != noone && isInWinnableTile() != noone{
				var _win_tile = isInWinnableTile()
				if (_tile.x == _win_tile.x && _tile.y == _win_tile.y){
					submitStar(obj_grid.level_index, 3)
				}
			} else {
				_tile = isInWinnableTile()
			}
		}
	} else if obj_grid.level_index == 6{
		var bounced = false
		with(obj_bumper){
			if isBounced {
				bounced = true
			}
		}
		if !bounced{
			submitStar(obj_grid.level_index,3)
		}
	} else{
		if timer <= global.conditions[obj_grid.level_index].third_star.nbSeconds{
			submitStar(obj_grid.level_index,3)
		}
	}
}

function checkStompTime(){
	if nbStomps <= global.conditions[obj_grid.level_index].second_star.nbStomps{
		submitStar(obj_grid.level_index,2)
	}
}

function checkAllMuttonsCompletion(){
	if obj_level_manager.nbMuttonArrived == global.conditions[obj_grid.level_index].muttons_total{
		submitStar(obj_grid.level_index,1)
	}
}

function checkSpecial(){
	
}