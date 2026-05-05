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
if (isDragging) {
    x -= (mx - dragStartX) * zoom_ammount;
    y -= (my - dragStartY) * zoom_ammount;
    dragStartX = mx;
    dragStartY = my;
}

camera_set_view_pos(cam,  floor(x - _camW / 2), floor(y - _camH / 2));
camera_set_view_size(cam, floor(_camW), floor(_camH));