gpu_set_tex_filter(false);

for (var j = 0; j < grid.height; j++) {
    for (var i = 0; i < grid.width; i++) {
        var iso_pos = _tile_to_world_pos(i, j);
        var value = ds_grid_get(grid.grid, i, j);
        draw_sprite_ext(spr_tile, value, iso_pos.x, iso_pos.y,1.001,1.001,0,c_white,1);
    }
}
