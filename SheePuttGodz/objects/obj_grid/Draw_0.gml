for (var j = 0; j < level.height; j++) {
    for (var i = 0; i < level.width; i++) {
        var iso_pos = game_pos_to_room_pos(i, j);
        
        // --- Dessin de la tuile ---
        var tile_idx = ds_grid_get(level.tiles_idx, i, j);
        if (tile_idx >= 5 && tile_idx <= 8) {
            shader_set(shd_wave);
            shader_set_uniform_f(wave_time, shd_time + i * 0.4 + j * 0.3);
            shader_set_uniform_f(wave_speed, 1.5);
            shader_set_uniform_f(wave_intensity, 0.06);
        }
        draw_sprite_ext(spr_tile, tile_idx, iso_pos.x, iso_pos.y, 1.001, 1.001, 0, c_white, 1);
        shader_reset();
        
        // --- Dessin de la déco (si présente) ---
        var deco_idx = ds_grid_get(level.decos_idx, i, j);
        if (deco_idx > 0) {
            if (deco_idx < 4) {
                shader_set(shd_wiggle);
                shader_set_uniform_f(wiggle_time, shd_time + i * 0.3 + j * 0.4);
                shader_set_uniform_f(wiggle_amplitude, 0.5);
                shader_set_uniform_f(wiggle_frequency, 0.1);
                shader_set_uniform_f(wiggle_speed, 1.0);
            }
            draw_sprite(spr_deco, deco_idx, iso_pos.x - 2, iso_pos.y + 9);
            shader_reset();
        }
		
		if ceil(selected_tile.x) == i && floor(selected_tile.y) == j{
			//draw_sprite(spr_tile,9,iso_pos.x,iso_pos.y)
		}
		
		//draw_text_transformed(iso_pos.x, iso_pos.y, "i:"+string(i)+", j:"+string(j),0.2,0.2,0)
        
    }
}

shd_time += 0.05;
