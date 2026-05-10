randomize()

tile_w = sprite_get_width(spr_tile) / 2;
tile_h = sprite_get_height(spr_tile) / 4;
tile_h_vertical = 2 * tile_h

function room_pos_to_game_pos(room_x, room_y) {
    var dx = room_x - grid_origin_x;
    var dy = room_y - grid_origin_y;

    var grid_x = (dx / tile_w + dy / tile_h) * 0.5 - 1;
    var grid_y = (dy / tile_h - dx / tile_w) * 0.5;

    return {
        x: grid_x,
        y: grid_y
    };
}

function game_pos_to_room_pos(game_x, game_y) {
    var room_x = (game_x - game_y) * tile_w;
    var room_y = (game_x + game_y) * tile_h;

    room_x += grid_origin_x;
    room_y += grid_origin_y;

    return {
        x: room_x,
        y: room_y
    };
}


level_index = 0
levels = get_levels()


grid_origin_x = room_width  / 2;
grid_origin_y = (room_height / 2) - (16 * tile_h); //todo remplacer 16 par level heit

muttons_for_win = 10
change_level(0)

function _iso_vec_to_screen(dx, dy) {
    var screen_dx = (dx - dy) * tile_w;
    var screen_dy = (dx + dy) * tile_h;
    return {x: screen_dx, y: screen_dy};
}

function _world_pos_to_tile(world_x, world_y) {
    var wx = world_x - grid_origin_x;
    var wy = world_y - grid_origin_y;
    var grid_x = (wx / tile_w + wy / tile_h) / 2;
    var grid_y = (wy / tile_h - wx / tile_w) / 2;
    return {x: grid_x, y: grid_y};
}

function _calculate_distance_and_orientation(tile_a, tile_b) {
    var dx = tile_b.x - tile_a.x;
    var dy = tile_b.y - tile_a.y;
    var dz = 0;
    var distance = sqrt(dx * dx + dy * dy + dz * dz);
    var angle = arctan2(dy, dx);
    return { dx: dx, dy: dy, dz: dz, distance: distance, angle: angle };
}

STOMPABLE_TILES = [1]

function is_stompable(game_x, game_y) {
    var floor_x = floor(game_x + 1)
    var floor_y = floor(game_y)
    
    if (floor_x < 0 || floor_y < 0) return false;
    if (floor_x >= level.width || floor_y >= level.height) return false;
        
    var value = ds_grid_get(level.grid, floor_x, floor_y);
    return array_contains(STOMPABLE_TILES, value);
}

WALKABLE_TILES = [1]
SWIMMABLE_TILES = [2]

function is_walkable(tile_x, tile_y) {
    if (tile_x < 0 || tile_y < 0) return false;
    if (tile_x >= level.width || tile_y >= level.height) return false;
    
    var value = ds_grid_get(level.grid, tile_x, tile_y);
    return array_contains(WALKABLE_TILES, value);
}

function is_swimable(tile_x, tile_y) {
    if (tile_x < 0 || tile_y < 0) return false;
    if (tile_x >= level.width || tile_y >= level.height) return false;
    
    var value = ds_grid_get(level.grid, tile_x, tile_y);
    return array_contains(SWIMMABLE_TILES, value);
}

function change_level(_level_index){
	with(obj_mutton){
		instance_destroy()
	}
	with(obj_end_gate){
		instance_destroy()
	}
	with(obj_foot_print){
		instance_destroy()
	}
    with(obj_bumper){
		instance_destroy()
	}
    with(obj_foot){
        instance_destroy()
    }
    instance_create_layer(mouse_x, mouse_y, "Instances", obj_foot)
	level_index = _level_index
	muttons_for_win = get_level_conditions(_level_index).muttons_for_win
	level = _build_level([levels[_level_index]]);
}

wiggle_time = shader_get_uniform(shd_wiggle, "u_time");
wiggle_amplitude = shader_get_uniform(shd_wiggle, "u_amplitude");
wiggle_frequency = shader_get_uniform(shd_wiggle, "u_frequency");
wiggle_speed = shader_get_uniform(shd_wiggle, "u_speed");

wave_time = shader_get_uniform(shd_wave, "u_time");
wave_speed = shader_get_uniform(shd_wave, "u_speed");
wave_intensity = shader_get_uniform(shd_wave, "u_intensity");

shd_time = 0;

