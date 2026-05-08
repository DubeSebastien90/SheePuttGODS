if (v_buffer_solid == undefined) exit;
    
var _tex = sprite_get_texture(spr_tiles, 0);

if (solid_exists) vertex_submit(v_buffer_solid, pr_trianglelist, _tex);
if (water_exists) {
    shader_set(shd_water);
    shader_set_uniform_f(water_time, current_time / 1000);
    vertex_submit(v_buffer_water, pr_trianglelist, _tex);
    shader_reset();
}

_tex = sprite_get_texture(spr_decos, 0);

if (decos_static_exists) vertex_submit(v_buffer_decos_static, pr_trianglelist, _tex);
    
if (decos_wiggle_exists) {
    shader_set(shd_wiggle);
    shader_set_uniform_f(wiggle_time, current_time / 1000);
    shader_set_uniform_f(wiggle_amplitude, 1.0);
    shader_set_uniform_f(wiggle_frequency, 0.1);
    shader_set_uniform_f(wiggle_speed, 1.0);
    vertex_submit(v_buffer_decos_wiggle, pr_trianglelist, _tex);
    shader_reset();
}