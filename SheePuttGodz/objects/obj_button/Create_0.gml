sprite_index = spr_button
image_index = 0
show = true
_alpha = show ? 1 : 0
selected = false
size = 1
temps = 0
_id = -1

function is_hovered(){
	var w = (sprite_get_width(sprite_index))/2
	var h = (sprite_get_height(sprite_index))/2
	var pos = obj_grid.room_pos_to_game_pos(mouse_x,mouse_y)
	if show{
	if (x - w <= pos.x && pos.x <= x + w) && (y - h <=pos.y && pos.y <= y + h) {
		return true
	}
	}
	return false
}