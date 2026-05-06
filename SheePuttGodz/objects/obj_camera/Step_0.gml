var mx = display_mouse_get_x();
var my = display_mouse_get_y();

var _camW = camW * zoom_ammount;
var _camH = camH * zoom_ammount;

if (mouse_check_button_pressed(mb_right)) {
    isDragging = true;
    dragStartX = mx;
    dragStartY = my;
}
if (mouse_check_button_released(mb_right)) {
    isDragging = false;
}

if mouse_wheel_down(){
	zoom_dir -= 0.01
}
if mouse_wheel_up(){
	zoom_dir += 0.01
}

zoom_ammount = lerp(zoom_ammount,zoom_dir,0.1)


if (isDragging) {
    x -= (mx - dragStartX) * zoom_ammount;
    y -= (my - dragStartY) * zoom_ammount;
    dragStartX = mx;
    dragStartY = my;
}

camera_set_view_pos(cam,  x - _camW / 2, y - _camH / 2);
camera_set_view_size(cam, _camW, _camH);