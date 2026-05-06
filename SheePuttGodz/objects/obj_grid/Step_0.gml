if keyboard_check_pressed(vk_right) {
    current_level = (current_level + 1) mod array_length(levels);
    level = levels[current_level];
}
if keyboard_check_pressed(vk_left) {
    current_level = (current_level - 1 + array_length(levels)) mod array_length(levels);
    level = levels[current_level];
}

if keyboard_check_pressed(vk_tab) {
    window_set_fullscreen(!window_get_fullscreen());
}

if keyboard_check_pressed(vk_space){
	screenShake(3,30)
}