//update destination
if (instance_exists(follow)) 
{
	xTo = follow.x +offsetX;
	yTo = follow.y +offsetY;
}

zoom_ammount = lerp(zoom_ammount,zoom_dir,zoom_lerp)
//zoom
var _camW = camW * zoom_ammount
var _camH = camH * zoom_ammount

//move camera
x += (xTo - x) / 5	
y += (yTo - y) / 5

//movement
if mouse_wheel_up(){
	zoom_dir *= 0.96
	zoom_dir = max(0.2,zoom_dir)
}
if mouse_wheel_down(){
	zoom_dir *= 1.04
	zoom_dir = min(1.2,zoom_dir)
}

if mouse_check_button_pressed(mb_right){
	initialDragX = mouse_x
	initialDragY = mouse_y
}
if mouse_check_button(mb_right){
	x -= mouse_x-initialDragX
	y -= mouse_y-initialDragY
}

var map_width = (obj_grid.height + obj_grid.width) * obj_grid.tile_w * 0.5
var map_height = (obj_grid.height + obj_grid.width) * obj_grid.tile_h * 0.5

//keep in center
x = clamp(x, (room_width / 2) - (_camW / 2) - (map_width / 2), (room_height / 2) + (_camW / 2) + (map_width / 2))
y = clamp(y, (room_height / 2) - (_camH / 2) - (map_height / 2), (room_height / 2) + (_camH / 2) + (map_height / 2))

//screen shake
x += random_range(-shake_remain,shake_remain);
y += random_range(-shake_remain,shake_remain);
shake_remain = max(0,shake_remain-((1/shake_lenght)*shake_magnitude));

//update camera view
camera_set_view_pos(cam,x-_camW/2,y-_camH/2);
camera_set_view_size(cam,_camW,_camH)

