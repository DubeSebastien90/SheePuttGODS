randomise();

v_format = undefined;
v_buffer_solid = undefined;
v_buffer_water = undefined;
v_buffer_decos_wiggle = undefined;
v_buffer_decos_static = undefined;
v_dynamic = vertex_create_buffer();
solid_exists = false;
water_exists = false;
decos_wiggle_exists = false;
decos_static_exists = false;

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();
v_format = vertex_format_end();

function build_mesh(_lvl) {
    if (v_buffer_solid != undefined) vertex_delete_buffer(v_buffer_solid);
    if (v_buffer_water != undefined) vertex_delete_buffer(v_buffer_water);
    if (v_buffer_decos_static != undefined) vertex_delete_buffer(v_buffer_decos_static);
    if (v_buffer_decos_wiggle != undefined) vertex_delete_buffer(v_buffer_decos_wiggle);

    v_buffer_solid = vertex_create_buffer();
    v_buffer_water = vertex_create_buffer();
    v_buffer_decos_static = vertex_create_buffer();
    v_buffer_decos_wiggle = vertex_create_buffer();

    vertex_begin(v_buffer_solid, v_format);
    vertex_begin(v_buffer_water, v_format);
    vertex_begin(v_buffer_decos_static, v_format);
    vertex_begin(v_buffer_decos_wiggle, v_format);

    var _map = _lvl.tiles_idx;
    var _decos = _lvl.decos_idx;
    var _w = _lvl.width;
    var _h = _lvl.height;
    var _count_s = 0;
    var _count_w = 0;
    var _count_d_w = 0;
    var _count_d_s = 0;

    for (var _y = 0; _y < _h; _y++) {
        for (var _x = 0; _x < _w; _x++) {
            var _id = _map[_y][_x];
            if (_id == 0) continue;

            var _is_water = (_id >= 5 && _id <= 8);
            var _buf = _is_water ? v_buffer_water : v_buffer_solid;

            _add_tile_to_mesh(_buf, _x, _y, _id, spr_tiles, 0);

            if (_is_water) _count_w++; else _count_s++;
                
            var _deco_id = _decos[_y][_x];
            if (_deco_id > 0) {
                if _is_water {
                    _add_tile_to_mesh(v_buffer_decos_static, _x, _y, _deco_id, spr_decos, 0.1);
                    _count_d_s++;
                } else {
                     _add_tile_to_mesh(v_buffer_decos_wiggle, _x, _y, _deco_id, spr_decos, 0.1);
                    _count_d_w++;
                }
            }
        }
    }
    
    solid_exists = _count_s > 0;
    water_exists = _count_s > 0;
    decos_static_exists = _count_d_s > 0;
    decos_wiggle_exists = _count_d_w > 0;
    

    if (solid_exists)  { vertex_end(v_buffer_solid); vertex_freeze(v_buffer_solid); }
    if (water_exists)  { vertex_end(v_buffer_water); vertex_freeze(v_buffer_water); }
    if (decos_static_exists)  { vertex_end(v_buffer_decos_static); vertex_freeze(v_buffer_decos_static); }
    if (decos_wiggle_exists)  { vertex_end(v_buffer_decos_wiggle); vertex_freeze(v_buffer_decos_wiggle); }
}

function _add_tile_to_mesh(_buf, _gx, _gy, _id, _spr, _z_offset) {
    var _sx = grid_to_room_x(_gx, _gy);
    var _sy = grid_to_room_y(_gx, _gy);

    var _z = get_iso_z(_gx, _gy) - _z_offset;

    var _uvs = sprite_get_uvs(_spr, _id);
    var _dw = sprite_get_width(_spr) * _uvs[6];
    var _dh = sprite_get_height(_spr) * _uvs[7];
    var _sw = _dw * 1.001; 
    var _sh = _dh * 1.001;
    var _offX = (_sw - _dw) / 2;
    var _offY = (_sh - _dh) / 2;
    var _x1 = (_sx + _uvs[4]) - _offX;
    var _y1 = (_sy + _uvs[5]) - _offY;
    var _x2 = _x1 + _sw;
    var _y2 = _y1 + _sh;
    vertex_position_3d(_buf, _x1, _y1, _z); vertex_color(_buf, c_white, 1); vertex_texcoord(_buf, _uvs[0], _uvs[1]);
    vertex_position_3d(_buf, _x2, _y1, _z); vertex_color(_buf, c_white, 1); vertex_texcoord(_buf, _uvs[2], _uvs[1]);
    vertex_position_3d(_buf, _x1, _y2, _z); vertex_color(_buf, c_white, 1); vertex_texcoord(_buf, _uvs[0], _uvs[3]);
    vertex_position_3d(_buf, _x2, _y1, _z); vertex_color(_buf, c_white, 1); vertex_texcoord(_buf, _uvs[2], _uvs[1]);
    vertex_position_3d(_buf, _x2, _y2, _z); vertex_color(_buf, c_white, 1); vertex_texcoord(_buf, _uvs[2], _uvs[3]);
    vertex_position_3d(_buf, _x1, _y2, _z); vertex_color(_buf, c_white, 1); vertex_texcoord(_buf, _uvs[0], _uvs[3]);
}

water_time = shader_get_uniform(shd_water, "u_time");
wiggle_time = shader_get_uniform(shd_wiggle, "u_time");
wiggle_amplitude = shader_get_uniform(shd_wiggle, "u_amplitude");
wiggle_frequency = shader_get_uniform(shd_wiggle, "u_frequency");
wiggle_speed = shader_get_uniform(shd_wiggle, "u_speed");