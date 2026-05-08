function grid_init(origin_x, origin_y, tw, th) {
    global.grid_origin_x = origin_x;
    global.grid_origin_y = origin_y;
    global.tile_w = tw;
    global.tile_h = th;
}

function grid_to_room_x(gx, gy) {
    return (gx - gy) * global.tile_w + global.grid_origin_x;
}

function grid_to_room_y(gx, gy) {
    return (gx + gy) * global.tile_h + global.grid_origin_y;
}

function room_to_grid_x(sx, sy) {
    var dx = sx - global.grid_origin_x;
    var dy = sy - global.grid_origin_y;
    return (dx / global.tile_w + dy / global.tile_h) * 0.5;
}

function room_to_grid_y(sx, sy) {
    var dx = sx - global.grid_origin_x;
    var dy = sy - global.grid_origin_y;
    return (dy / global.tile_h - dx / global.tile_w) * 0.5;
}

function get_iso_z(gx, gy) {
    var lv  = global.current_level;
    var _max = lv.width + lv.height;
    return (_max - gx - gy) / _max;
}

function is_in_bounds(gx, gy) {
    var lv = global.current_level;
    return gx >= 0 && gy >= 0 && gx < lv.width && gy < lv.height;
}

function is_walkable(gx, gy) {
    if (!is_in_bounds(gx, gy)) return 0;
    return global.current_level.grid[gy][gx] == 1;
}

function draw_iso_sprite(_spr, _subimg, _gx, _gy, _z_offset = 0.005) {
    var _sx = grid_to_room_x(_gx, _gy);
    var _sy = grid_to_room_y(_gx, _gy);
    
    if (!is_walkable(floor(_gx), floor(_gy))) {
        _sy += global.tile_h;
    }
    
    var _z = get_iso_z(_gx, _gy);
    
    var _mat = matrix_build(0, 0, _z, 0, 0, 0, 1, 1, 1);
    matrix_set(matrix_world, _mat);
    
    draw_sprite(_spr, _subimg, _sx, _sy);
    
    matrix_set(matrix_world, matrix_build_identity());
}