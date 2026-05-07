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
                shockwave_spr_idx = 0;
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
            shockwave_ready = true;

            var _feet_tile = obj_grid._world_pos_to_tile(x, y);
            var _ftx = _feet_tile.x;
            var _fty = _feet_tile.y;
            with (obj_mutton) {
                var _mut_tile = obj_grid._world_pos_to_tile(x, y);
                var _ddx = _mut_tile.x - _ftx;
                var _ddy = _mut_tile.y - _fty;
                var _dist = sqrt(_ddx * _ddx + _ddy * _ddy);
                if (_dist > 0 && _dist <= 10) {
                    var _force = other.max_force_repulsion * (1 - _dist / 3);
                    dx += (_ddx / _dist) * _force;
                    dy += (_ddy / _dist) * _force;
                    dz = jumpForce;
                    in_air = true;
                }
            }

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
