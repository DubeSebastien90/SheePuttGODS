#macro TILE_W 16
#macro TILE_H 8

function grid_to_room_x(gx, gy) {
    return (gx - gy) * TILE_W;
}

function grid_to_room_y(gx, gy) {
    return (gx + gy) * TILE_H;
}

function room_to_grid_x(sx, sy) {
    return (sy / TILE_H + sx / TILE_W) * 0.5;
}

function room_to_grid_y(sx, sy) {
    return (sy / TILE_H - sx / TILE_W) * 0.5;
}

function draw_iso(_vbuf, _spr, _subimg, _gx, _gy, _gz = 0, _z_offset = 0.005) {
    var _sx = grid_to_room_x(_gx, _gy);
    var _sy = grid_to_room_y(_gx, _gy) - (_gz * TILE_H * 2);
    
    var _z = -(_gx + _gy + _gz) - _z_offset;

    var _uvs = sprite_get_uvs(_spr, _subimg);
    var _x_off = sprite_get_xoffset(_spr);
    var _y_off = sprite_get_yoffset(_spr);
    
    var _dw = sprite_get_width(_spr) * _uvs[6];
    var _dh = sprite_get_height(_spr) * _uvs[7];

    var _x1 = (_sx - _x_off) + _uvs[4];
    var _y1 = (_sy - _y_off) + _uvs[5];
    var _x2 = _x1 + _dw;
    var _y2 = _y1 + _dh;

    vertex_position_3d(_vbuf, _x1, _y1, _z); vertex_color(_vbuf, c_white, 1); vertex_texcoord(_vbuf, _uvs[0], _uvs[1]);
    vertex_position_3d(_vbuf, _x2, _y1, _z); vertex_color(_vbuf, c_white, 1); vertex_texcoord(_vbuf, _uvs[2], _uvs[1]);
    vertex_position_3d(_vbuf, _x1, _y2, _z); vertex_color(_vbuf, c_white, 1); vertex_texcoord(_vbuf, _uvs[0], _uvs[3]);

    vertex_position_3d(_vbuf, _x2, _y1, _z); vertex_color(_vbuf, c_white, 1); vertex_texcoord(_vbuf, _uvs[2], _uvs[1]);
    vertex_position_3d(_vbuf, _x2, _y2, _z); vertex_color(_vbuf, c_white, 1); vertex_texcoord(_vbuf, _uvs[2], _uvs[3]);
    vertex_position_3d(_vbuf, _x1, _y2, _z); vertex_color(_vbuf, c_white, 1); vertex_texcoord(_vbuf, _uvs[0], _uvs[3]);
}