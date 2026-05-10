// --- Dessin de la tuile ---
for (var j = 0; j < level.height; j++) {
    for (var i = 0; i < level.width; i++) {
        var tile = ds_grid_get(level.tiles, i, j);
        if (tile.val == 0) continue;
            
        if (tile.val >= 5 && tile.val <= 8) {
            shader_set(shd_wave);
            shader_set_uniform_f(wave_time, shd_time + i * 0.4 + j * 0.3);
            shader_set_uniform_f(wave_speed, 1.5);
            shader_set_uniform_f(wave_intensity, 0.06);
        }
        draw_sprite_ext(spr_tile, tile.val, tile.x, tile.y, 1.001, 1.001, 0, c_white, 1);
        shader_reset();
    }
}

// --- Dessin de la deco statique ---
for (var j = 0; j < level.height; j++) {
    for (var i = 0; i < level.width; i++) {
        var decos_s = ds_grid_get(level.decos_s, i, j);
        if (decos_s.val == 0) continue;
        draw_sprite(spr_deco, decos_s.val, decos_s.x, decos_s.y);
    }
}

// --- Dessin de la deco dynamique ---
shader_set(shd_wiggle);
shader_set_uniform_f(wiggle_time, shd_time + i * 0.3 + j * 0.4);
shader_set_uniform_f(wiggle_amplitude, 0.5);
shader_set_uniform_f(wiggle_frequency, 0.1);
shader_set_uniform_f(wiggle_speed, 1.0);
for (var j = 0; j < level.height; j++) {
    for (var i = 0; i < level.width; i++) {
        var decos_d = ds_grid_get(level.decos_d, i, j);
        if (decos_d.val == 0) continue;
        draw_sprite(spr_deco, decos_d.val, decos_d.x, decos_d.y);
    }
}
shader_reset();

shd_time += 0.05;
