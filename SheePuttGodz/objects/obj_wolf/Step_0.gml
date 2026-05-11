if obj_level_manager.menuState == 1 exit;
if stun_time > 0 {
    --stun_time;
    exit;
}

if state == "searching" {
    path_time--;
    if path_time <= 0 {

        var _queue = ds_priority_create();
        with (obj_mutton) {
            var _d = point_distance(other.grid_x, other.grid_y, grid_x, grid_y);
            ds_priority_add(_queue, { sheep_id: id, dist: _d }, _d);
        }

        while !ds_priority_empty(_queue) {
            var _entry = ds_priority_delete_min(_queue);
            if _entry.dist > aggro_range break;

            var _sheep = _entry.sheep_id;
            if instance_exists(_sheep) && !_sheep.on_water {
                var _ang = random(360);
                var _r = random_range(0.05, approach_radius);
                var tx = _sheep.grid_x + 0.5 + lengthdir_x(_r, _ang);
                var ty = _sheep.grid_y + 0.5 + lengthdir_y(_r, _ang);

                if mp_grid_path(mp_grid, my_path, grid_x + 0.5, grid_y + 0.5, tx, ty, true) {
                    current_node = 1;
                    target_sheep = _sheep;
                    state = "chasing";
                    break;
                }
            }
        }
        ds_priority_destroy(_queue);
        path_time = path_timer + irandom_range(-path_jitter, path_jitter);
    }
} else if state == "chasing" {
    if !instance_exists(target_sheep) {
        state = "searching";
        path_time = 0;
    } else {
        path_time--;
        if path_time <= 0 {
            var _ang = random(360);
            var _r = random_range(0.05, approach_radius);
            var tx = target_sheep.grid_x + 0.5 + lengthdir_x(_r, _ang);
            var ty = target_sheep.grid_y + 0.5 + lengthdir_y(_r, _ang);

            if mp_grid_path(mp_grid, my_path, grid_x + 0.5, grid_y + 0.5, tx, ty, true) {
                current_node = 1;
            } else {
                state     = "searching";
                path_time = 0;
            }
            path_time = path_timer + irandom_range(-path_jitter, path_jitter);
        }

        var _path_points = path_get_number(my_path);
        if current_node < _path_points {

            var node_gx = path_get_point_x(my_path, current_node) - 0.5;
            var node_gy = path_get_point_y(my_path, current_node) - 0.5;
            var _d = point_distance(grid_x, grid_y, node_gx, node_gy);

            var move_dx, move_dy;
            if _d <= walkspd {
                move_dx = node_gx - grid_x;
                move_dy = node_gy - grid_y;
                grid_x  = node_gx;
                grid_y  = node_gy;
                current_node++;
            } else {
                move_dx = (node_gx - grid_x) / _d * walkspd;
                move_dy = (node_gy - grid_y) / _d * walkspd;
                grid_x += move_dx;
                grid_y += move_dy;
            }

            var _screen = obj_grid._iso_vec_to_screen(move_dx, move_dy);
            x += _screen.x;
            y += _screen.y;

            var _dist_3d = point_distance_3d(
                grid_x, grid_y, 0,
                target_sheep.grid_x, target_sheep.grid_y, target_sheep.z
            );
            if _dist_3d < atck_range {
                if !target_sheep.mort {
                    target_sheep.mort = true;
                    target_sheep.dx = target_sheep.dy = target_sheep.dz = 0;
                }
                eat_time = eat_timer;
                state = "eating";
            }
        } else {
            path_time = 0;
        }
    }
} else if state == "eating" {
    eat_time--;
    if instance_exists(target_sheep) {
        target_sheep.grid_x = grid_x;
        target_sheep.grid_y = grid_y;
        target_sheep.z      = 0;
        target_sheep.image_xscale = max(0, target_sheep.image_xscale - 0.05);
        target_sheep.image_yscale = max(0, target_sheep.image_yscale - 0.05);

        if eat_time <= 0 {
            instance_destroy(target_sheep);
            state = "searching";
            path_time = irandom_range(0, path_jitter);
        }
    } else {
        state = "searching";
        path_time = irandom_range(0, path_jitter);
    }
}

depth = -bbox_bottom;