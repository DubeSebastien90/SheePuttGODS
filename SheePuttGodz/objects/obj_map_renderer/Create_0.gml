gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

v_format = undefined;
v_buffer_solid = undefined;
v_buffer_water = undefined;
solid_exists = false;
water_exists = false;

u_time = shader_get_uniform(shd_water, "u_time");

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color();
vertex_format_add_texcoord();
v_format = vertex_format_end();

function rebuild_mesh(_lvl) {
    if (v_buffer_solid != undefined) vertex_delete_buffer(v_buffer_solid);
    if (v_buffer_water != undefined) vertex_delete_buffer(v_buffer_water);

    v_buffer_solid = vertex_create_buffer();
    v_buffer_water = vertex_create_buffer();

    vertex_begin(v_buffer_solid, v_format);
    vertex_begin(v_buffer_water, v_format);

    var _map = _lvl.tiles_idx;
    var _w = _lvl.width;
    var _h = _lvl.height;
    var _count_s = 0;
    var _count_w = 0;

    for (var _y = 0; _y < _h; _y++) {
        for (var _x = 0; _x < _w; _x++) {
            var _id = _map[_y][_x];
            if (_id == 0) continue;

            var _is_water = (_id >= 5 && _id <= 8);
            var _buf = _is_water ? v_buffer_water : v_buffer_solid;

            _add_tile_to_mesh(_buf, _x, _y, _id, _is_water);

            if (_is_water) _count_w++; else _count_s++;
        }
    }

    solid_exists = (_count_s > 0);
    water_exists = (_count_w > 0);

    if (solid_exists) { vertex_end(v_buffer_solid); vertex_freeze(v_buffer_solid); }
    if (water_exists) { vertex_end(v_buffer_water); vertex_freeze(v_buffer_water); }
}

function _add_tile_to_mesh(_buf, _gx, _gy, _id, _is_w) {
    var _sx = grid_to_screen_x(_gx, _gy);
    var _sy = grid_to_screen_y(_gx, _gy);

    var _z = get_iso_z(_gx, _gy);

    var _uvs = sprite_get_uvs(spr_tiles, _id);
    var _dw = sprite_get_width(spr_tiles) * _uvs[6];
    var _dh = sprite_get_height(spr_tiles) * _uvs[7];
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