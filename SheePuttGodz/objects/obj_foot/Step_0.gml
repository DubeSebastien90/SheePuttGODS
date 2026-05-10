switch (state) {
    case "marking":
        var game_pos = obj_grid.room_pos_to_game_pos(mouse_x, mouse_y);
        
        if obj_grid.is_stompable(game_pos.x, game_pos.y) {
            x = mouse_x;
            y = mouse_y;

            if (mouse_check_button_pressed(mb_left) && obj_level_manager.menuState == 0) {
                impact.x = x;
                impact.y = y;
                height_offset = start_height;
                sprite_index = spr_foot;
                image_index = 0;
                image_speed = 0;
                clouds_spr_idx = 0;
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
            clouds_active = true;
            shockwave_active = true;
            shockwave_time   = 0;

            var _feet_tile = obj_grid.room_pos_to_game_pos(impact.x, impact.y);
            var _ftx = _feet_tile.x;
            var _fty = _feet_tile.y;
            with (obj_mutton) {
                var _mut_tile = obj_grid.room_pos_to_game_pos(x, y+offset_origin);
                var _ddx = _mut_tile.x - _ftx;
                var _ddy = _mut_tile.y - _fty;
                var _dist = sqrt(_ddx * _ddx + _ddy * _ddy);
				if _dist <= other.distStomp && z == 0 && on_land{
					stomped()
				} else if !mort{
                if (_dist > 0 && _dist <= other.max_repulsion_dist) && on_land{
					footMovement = true
                    var _force = other.max_force_repulsion * (1 - _dist / other.max_repulsion_dist);
                    dx += (_ddx / _dist) * _force;
                    dy += (_ddy / _dist) * _force;
					if _dist < other.max_jump_dist{
						dz = jumpForce //* (1 - _dist / other.max_jump_dist);
						in_air = true;
					}
					scaredTime = scaredMaxTime
                }
				}
            }
			
			instance_create_layer(impact.x,impact.y,"dessous",obj_foot_print)
			
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
                //instance_create_depth(impact.x, impact.y, -1, obj_footprint)
                state = "ascending";
            }
        }
    break;

    case "ascending":
        speed = min(speed + acceleration * 0.7, max_speed - 6);
        height_offset = min(height_offset + speed, start_height);
        
        if (height_offset == start_height) {
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

depth = -impact.y-origin_ofsset_y