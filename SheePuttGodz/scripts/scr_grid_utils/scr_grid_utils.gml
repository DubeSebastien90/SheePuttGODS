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

function try_move(_gx, _gy, _gz, _dx, _dy, _dz, _in_air) {
    var _applied_dx = 0;
    var _applied_dy = 0;
    var _applied_dz = 0;

    if (_in_air) {
        _applied_dx = _dx;
        _applied_dy = _dy;
    } else {
        var _on_land  = is_walkable(floor(_gx), floor(_gy));
        var _on_water = is_water(floor(_gx), floor(_gy));

        var _can_enter = function(_tx, _ty, _land, _water) {
            if (_land  && is_walkable(_tx, _ty)) return true;
            if (_water && is_water(_tx, _ty))    return true;
            return false;
        };
        
        var _r = 0.2;

        if (_dx != 0) {
            var _edge_x       = _gx + _dx + sign(_dx) * _r;
            var _corner_y_top = _gy - _r;
            var _corner_y_bot = _gy + _r;
            if (_can_enter(floor(_edge_x), floor(_corner_y_top), _on_land, _on_water)
            &&  _can_enter(floor(_edge_x), floor(_corner_y_bot), _on_land, _on_water)) {
                _applied_dx = _dx;
            }
        }

        // axis y
        if (_dy != 0) {
            var _edge_y         = _gy + _dy + sign(_dy) * _r;
            var _corner_x_left  = _gx - _r;
            var _corner_x_right = _gx + _r;
            if (_can_enter(floor(_corner_x_left),  floor(_edge_y), _on_land, _on_water)
            &&  _can_enter(floor(_corner_x_right), floor(_edge_y), _on_land, _on_water)) {
                _applied_dy = _dy;
            }
        }
    }

    if (_gz + _dz < 0) {
        _applied_dz = -_gz;
    } else {
        _applied_dz = _dz;
    }

    return { dx: _applied_dx, dy: _applied_dy, dz: _applied_dz };
}

function is_inbounds(gx, gy) {
    var lv = global.current_level;
    return gx >= 0 && gy >= 0 && gx < lv.width && gy < lv.height;
}

function is_water(gx, gy) {
    return global.current_level.grid[gy][gx] == 2;
}

function is_walkable(gx, gy) {
    return global.current_level.grid[gy][gx] == 1;
}

function draw_iso_sprite(_spr, _subimg, _gx, _gy, _gz = 0, _z_offset = 0.01) {
    var _pos = _draw_math(_gx, _gy, _z_offset, _gz);
    draw_sprite(_spr, _subimg, _pos.x, _pos.y);
    matrix_set(matrix_world, matrix_build_identity());
}

function draw_iso_sprite_ext(_spr, _subimg, _gx, _gy, _gz = 0, _xscale, _yscale, _rot, _color, _alpha, _z_offset = 0.015) {
    var _pos = _draw_math(_gx, _gy, _z_offset, _gz);
    draw_sprite_ext(_spr, _subimg, _pos.x, _pos.y, _xscale, _yscale, _rot, _color, _alpha);
    matrix_set(matrix_world, matrix_build_identity());
}

function _draw_math(_gx, _gy, _z_offset, _gz) {
    var _sx = grid_to_room_x(_gx, _gy);
    var _sy = grid_to_room_y(_gx, _gy) - (_gz * global.tile_h);
    var _z  = get_iso_z(_gx, _gy) - _z_offset;
    
    if (is_inbounds(floor(_gx), floor(_gy)) && is_water(floor(_gx), floor(_gy))) {
        _sy += global.tile_h;
    }
    
    matrix_set(matrix_world, matrix_build(0, 0, _z, 0, 0, 0, 1, 1, 1));
    return { x: _sx, y: _sy, z: _z };
}
