if keyboard_check_pressed(vk_tab) {
    window_set_fullscreen(!window_get_fullscreen());
}

if debug_mode {
    if keyboard_check_pressed(vk_right) {
        // Updated to use global.cached_levels
        change_level((level_index + 1) mod array_length(global.cached_levels));
    }
    
    if keyboard_check_pressed(vk_left) {
        // Updated to use global.cached_levels
        change_level((level_index - 1 + array_length(global.cached_levels)) mod array_length(global.cached_levels));
    }

    if keyboard_check_pressed(ord("R")){
        // 'R' just resets to the first level using the cached data
        change_level(0);
    }
}

selected_tile = room_pos_to_game_pos(mouse_x,mouse_y);