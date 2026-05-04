for (var j = 0; j < height; j++) {
    for (var i = 0; i < width; i++) {
        var iso_pos = _tile_to_world_pos(i, j)
        var current_drawn_tile = ds_grid_get(grid, i, j)
        var current_deco_tile = ds_grid_get(gridDeco, i, j)

		if current_drawn_tile.value == 6{
            var tile = 2
            if current_deco_tile.value != 0{
                tile = 11 + current_deco_tile.value
            }
            draw_sprite(spr_tile, tile, iso_pos.x, iso_pos.y)
        } else {
            if current_drawn_tile.value = 7{
                if get_sub_bridge(i,j) == 7{
                    draw_sprite(spr_tile, 7, iso_pos.x, iso_pos.y)
                } else if get_sub_bridge(i,j) == 8{
                    draw_sprite(spr_tile, 8, iso_pos.x, iso_pos.y)
                } else draw_sprite(spr_tile, 6, iso_pos.x, iso_pos.y)
            } else if current_drawn_tile.value == 8{
                draw_sprite(spr_tile, 5, iso_pos.x, iso_pos.y)
            } else {
                var tile = 0
                if current_deco_tile.value != 0{
                    tile = 8 + current_deco_tile.value
                }
                draw_sprite(spr_tile, tile, iso_pos.x, iso_pos.y)
            }
        }

    }
}
