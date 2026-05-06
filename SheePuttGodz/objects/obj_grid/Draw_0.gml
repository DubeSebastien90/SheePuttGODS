for (var j = 0; j < level.height; j++) {
    for (var i = 0; i < level.width; i++) {
        var iso_pos = game_pos_to_room_pos(i, j);
        
        var tile_idx = ds_grid_get(level.tiles_idx, i, j);
        draw_sprite_ext(spr_tile, tile_idx, iso_pos.x, iso_pos.y,1.001,1.001,0,c_white,1);
        
        var deco_idx = ds_grid_get(level.decos_idx, i, j);
        if deco_idx == 0 continue;
        draw_sprite_ext(spr_deco, deco_idx, iso_pos.x - 2, iso_pos.y + 9,1,1,0,c_white,1);
    }
}
