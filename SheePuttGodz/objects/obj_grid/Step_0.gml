if keyboard_check_pressed(vk_tab) {
    window_set_fullscreen(!window_get_fullscreen());
}

if debug_mode {
    if keyboard_check_pressed(vk_right) {
        level_index = (level_index + 1) mod array_length(levels);
        level = levels[level_index];
    }
    
    if keyboard_check_pressed(vk_left) {
        level_index = (level_index - 1 + array_length(levels)) mod array_length(levels);
        level = levels[level_index];
    }

    if keyboard_check_pressed(ord("R")){
        levels = get_levels()
        level = levels[level_index];
    }
}
