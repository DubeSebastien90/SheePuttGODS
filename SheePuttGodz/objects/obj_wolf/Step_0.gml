var _player = instance_nearest(x, y, obj_mutton);

if (_player != noone ) { 
    if (state == "chase") {
        
        path_timer--;
        
        // 1. Calculate Path
        if (path_timer <= 0) {
            var _current_map = obj_grid.level.mp_grid;
            
            var start_x = grid_x + 0.5;
            var start_y = grid_y + 0.5;
            var target_x = _player.grid_x + 0.5;
            var target_y = _player.grid_y + 0.5;
            
            if (mp_grid_path(_current_map, my_path, start_x, start_y, target_x, target_y, true)) {
                current_node = 1; 
                path_timer = 30;  
            }
        }
        
        // 2. Follow Path
        var path_points = path_get_number(my_path);
        
        if (current_node < path_points) {
            var target_x = path_get_point_x(my_path, current_node) - 0.5;
            var target_y = path_get_point_y(my_path, current_node) - 0.5;
            
            var _dist_2d = point_distance(grid_x, grid_y, target_x, target_y);
            
            if (_dist_2d <= walkspd) {
                grid_x = target_x;
                grid_y = target_y;
                current_node++; 
            } else {
                var nx = (target_x - grid_x) / _dist_2d;
                var ny = (target_y - grid_y) / _dist_2d;
                
                var move_dx = nx * walkspd;
                var move_dy = ny * walkspd;
                
                grid_x += move_dx;
                grid_y += move_dy;
                
                var move_screen = obj_grid._iso_vec_to_screen(move_dx, move_dy);
                x += move_screen.x;
                y += move_screen.y;
            }
        }
        
        // 3. Catch Trigger
        var _dist_3d = point_distance_3d(grid_x, grid_y, 0, _player.grid_x, _player.grid_y, _player.z);
        if (_dist_3d < 0.5) {
            state = "eat";
            eat_timer = 60; 
            target_sheep = _player;
            
            // NEW: Only trigger the "death" variables if the sheep was alive!
            // This prevents multiple wolves from resetting the death state.
            if (!_player.mort) {
                _player.mort = true;
                _player.canControl = false;
                _player.dx = 0;
                _player.dy = 0;
                _player.dz = 0;
            }
        }
    }
}

if (state == "eat") {
    eat_timer--;
    if (instance_exists(target_sheep)) {
        target_sheep.grid_x = grid_x;
        target_sheep.grid_y = grid_y;
        target_sheep.z = 0;
        
        target_sheep.image_xscale = max(0, target_sheep.image_xscale - 0.05);
        target_sheep.image_yscale = max(0, target_sheep.image_yscale - 0.05);
        
        if (eat_timer <= 0) {
            with (target_sheep) { 
                instance_destroy(); 
            }
            state = "chase";
            path_timer = 0;
        }
    } else {
        state = "chase";
    }
}

depth = -bbox_bottom;
