nbStomps = 0
timer = 0

function resetMetrics(){
	nbStomps = 0
	timer = 0
}

function submitStar(level, num){
	if num == 1 {
		global.conditions[level].first_star.collected = true
	}
	if num == 2 {
		global.conditions[level].second_star.collected = true
	}
	if num == 3 {
		global.conditions[level].third_star.collected = true
	}
}

function checkLevelTime(){
	if timer <= global.conditions[obj_grid.level_index].third_star.nbSeconds{
		submitStar(obj_grid.level_index,3)
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