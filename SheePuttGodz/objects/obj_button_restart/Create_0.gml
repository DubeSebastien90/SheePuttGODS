_size = 3
image_index = 0
show = true
_alpha = show ? 1 : 0
selected = false
size = 1
temps = 0

rot = 0
_temps = 0

function is_hovered(){
	if !show return false;
	var mxg = device_mouse_x_to_gui(0);
	var myg = device_mouse_y_to_gui(0);
	var w = sprite_get_width(sprite_index)*_size / 2;
	var h = sprite_get_height(sprite_index)*_size / 2;
	return (x - w <= mxg && mxg <= x + w) && (y - h <= myg && myg <= y + h);
}

function on_clicked(){
	obj_grid.change_level(obj_grid.level_index)
	obj_star_manager.resetMetrics()
}