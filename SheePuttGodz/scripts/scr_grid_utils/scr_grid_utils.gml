function grid_init(origin_x, origin_y, tw, th) {
    global.grid_origin_x = origin_x;
    global.grid_origin_y = origin_y;
    global.tile_w = tw;
    global.tile_h = th;
}

function grid_to_screen_x(gx, gy) {
    return (gx - gy) * global.tile_w + global.grid_origin_x;
}

function grid_to_screen_y(gx, gy) {
    return (gx + gy) * global.tile_h + global.grid_origin_y;
}

function get_iso_z(gx, gy) {
    var lv  = global.current_level;
    var _max = lv.width + lv.height;
    return (_max - gx - gy) / _max;
}

function screen_to_grid_x(sx, sy) {
    var dx = sx - global.grid_origin_x;
    var dy = sy - global.grid_origin_y;
    return (dx / global.tile_w + dy / global.tile_h) * 0.5;
}

function screen_to_grid_y(sx, sy) {
    var dx = sx - global.grid_origin_x;
    var dy = sy - global.grid_origin_y;
    return (dy / global.tile_h - dx / global.tile_w) * 0.5;
}

function is_in_bounds(gx, gy) {
    var lv = global.current_level;
    return gx >= 0 && gy >= 0 && gx < lv.width && gy < lv.height;
}

function get_tile(gx, gy) {
    if (!is_in_bounds(gx, gy)) return 0;
    return global.current_level.grid[gy][gx];
}

function is_walkable(gx, gy) {
    return get_tile(gx, gy) == 1;
}

function is_stompable(game_x, game_y) {
    return is_walkable(floor(game_x + 1), floor(game_y));
}