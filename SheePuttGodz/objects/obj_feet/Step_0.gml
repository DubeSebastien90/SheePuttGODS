switch (state) {

    case "marking":
        var game_pos = obj_grid.room_pos_to_game_pos(mouse_x, mouse_y);
        
        if obj_grid.is_stompable(game_pos.x, game_pos.y) {
            x = mouse_x;
            y = mouse_y;

            if (mouse_check_button_pressed(mb_left)) {
                impact.x = x;
                impact.y = y;
                show_debug_message(impact)
                height_offset = start_height;
                sprite_index = spr_feet;
                image_index = 0;
                image_speed = 0;
                state = "descending";
            }
        } else {
            x = -1;
            y = -1;
        }
    break;

    case "descending":
        speed = min(speed + acceleration, max_speed);
        height_offset = max(0, height_offset - speed);

        if (height_offset == 0) {
            speed = 0;
            image_speed = 1;
            screenShake(3,30);
            state = "stomping";
        }
    break;

    case "stomping":
        if (image_index >= image_number - 1) {
            image_speed = 0;
            stomp_hold++;
            
            if (stomp_hold >= stomp_hold_max) {
                stomp_hold = 0;
                image_speed = -0.1;
                state = "ascending";
            }
        }
    break;

    case "ascending":
        speed = min(speed + acceleration * 0.7, max_speed - 6);
        height_offset += speed;
        
        if (image_index <= 0) {
            speed = 0;
            height_offset = 0;
            sprite_index = spr_marker;
            image_speed = 0;
            x = -1;
            y = -1;
            state = "marking";
        }
    break;
}
