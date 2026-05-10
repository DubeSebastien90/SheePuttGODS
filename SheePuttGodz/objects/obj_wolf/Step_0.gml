if state == "searching" {
    path_time--;
    if (path_time <= 0) {
        var _queue = ds_priority_create();
        
        with (obj_mutton) {
            var _dist = point_distance(other.grid_x, other.grid_y, grid_x, grid_y);
            ds_priority_add(_queue, {id, _dist}, _dist)
        }
        
        while (!ds_priority_empty(_queue)) {
            var _closest = ds_priority_delete_min(_queue);
            if _closest._dist > aggro_range break;
            
            var _sheep = _closest.id;
            if (instance_exists(_sheep) && !_sheep.on_water) {
                var start_x = grid_x + 0.5;
                var start_y = grid_y + 0.5;
                var target_x = _sheep.grid_x + 0.5;
                var target_y = _sheep.grid_y + 0.5;
                
                if (mp_grid_path(mp_grid, my_path, start_x, start_y, target_x, target_y, true)) {
                    current_node = 1;
                    target_sheep = _sheep;
                    state = "chasing"
                    break;
                }
            }
        }
        path_time = path_timer;
        ds_priority_destroy(_queue);
    }
} else if state  == "chasing" {
    path_time--;
    if (path_time <= 0) {
        state = "searching";
    } else if (instance_exists(target_sheep)) {
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
          
            var _dist_3d = point_distance_3d(grid_x, grid_y, 0, target_sheep.grid_x, target_sheep.grid_y, target_sheep.z);
            if (_dist_3d < 0.5) {
                if (!target_sheep.mort) {
                    target_sheep.mort = true;
                    target_sheep.dx = 0;
                    target_sheep.dy = 0;
                    target_sheep.dz = 0;
                }
                eat_time = eat_timer;
                state = "eating";
           }
        }
    } else state = "searching";
} else if state == "eating" {
    eat_time--;
    if (instance_exists(target_sheep)) {
        target_sheep.grid_x = grid_x;
        target_sheep.grid_y = grid_y;
        target_sheep.z = 0;
        
        target_sheep.image_xscale = max(0, target_sheep.image_xscale - 0.05);
        target_sheep.image_yscale = max(0, target_sheep.image_yscale - 0.05);
        
        if (eat_time <= 0) {
            with (target_sheep) { 
                instance_destroy(); 
            }
            path_time = path_timer;
            state = "searching";
        }
    } else {
        state = "searching";
    }
}

depth = -bbox_bottom;