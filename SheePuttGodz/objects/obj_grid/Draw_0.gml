for (var j = 0; j < level.height; j++) {
    for (var i = 0; i < level.width; i++) {
        var iso_pos = game_pos_to_room_pos(i, j);
        var value = ds_grid_get(level.sprites_idx, i, j);
        draw_sprite_ext(spr_tile, value, iso_pos.x, iso_pos.y,1.001,1.001,0,c_white,1);
    }
}
