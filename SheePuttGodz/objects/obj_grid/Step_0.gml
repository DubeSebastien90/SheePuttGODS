// Triple-R to reset save file
if reset_r_timer > 0 {
    reset_r_timer--;
} else {
    reset_r_count = 0;
}

if keyboard_check_pressed(ord("R")) {
    reset_r_count++;
    reset_r_timer = 60;

    if reset_r_count >= 3 {
        reset_r_count = 0;
        reset_r_timer = 0;
        for (var _i = 0; _i < array_length(global.conditions); _i++) {
            var _cond = global.conditions[_i];
            _cond.first_star.collected = false;
            _cond.second_star.collected = false;
            _cond.third_star.collected = false;
        }
        if !HTML_BUILD {
            saveConditions();
			level_index = 0
			change_level(0)
        }
    }

}

if keyboard_check_pressed(vk_tab) {
    window_set_fullscreen(!window_get_fullscreen());
}

if true {
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
        //change_level(0);
    }
}

selected_tile = room_pos_to_game_pos(mouse_x,mouse_y);