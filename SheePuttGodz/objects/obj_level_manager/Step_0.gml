if keyboard_check_pressed(vk_tab) {
    window_set_fullscreen(!window_get_fullscreen());
}

if debug_mode {
    if (keyboard_check_pressed(ord("R"))) load_level(current_level_index);
    if (keyboard_check_pressed(vk_right)) load_level(++current_level_index);
    if (keyboard_check_pressed(vk_left)) load_level(--current_level_index);
}