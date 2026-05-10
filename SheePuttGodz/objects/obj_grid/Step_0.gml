if keyboard_check_pressed(vk_tab) {
    window_set_fullscreen(!window_get_fullscreen());
}

if debug_mode {
    if keyboard_check_pressed(vk_right) {
		change_level((level_index + 1) mod array_length(levels))
    }
    
    if keyboard_check_pressed(vk_left) {
        change_level((level_index - 1 + array_length(levels)) mod array_length(levels))
    }

    if keyboard_check_pressed(ord("R")){
        levels = get_levels()
        change_level(0)
    }
}

selected_tile = room_pos_to_game_pos(mouse_x,mouse_y)
