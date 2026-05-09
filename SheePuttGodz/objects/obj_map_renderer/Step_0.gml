vertex_begin(vbuff_dynamic_3D, v_format);
with (obj_dynamic_3D) {
    var _iso_x = (world_x - world_y) * (TILE_W / 2);
    var _iso_y = (world_x + world_y) * (TILE_H / 2) - (world_z * Z_PIXELS);
    var _render_depth = -(world_x + world_y + world_z);
    
    _iso_x -= sprite_xoffset;
    _iso_y -= sprite_yoffset;
    
    var _uvs = sprite_get_uvs(sprite_index, image_index);
    other.write_quad(other.vbuff_dynamic_3D, _iso_x, _iso_y, _render_depth, _uvs, sprite_width, sprite_height);
}
vertex_end(vbuff_dynamic_3D);