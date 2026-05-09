if (v_buffer_solid == undefined) exit;
    
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);
gpu_set_alphatestref(128);
    
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

vertex_begin(v_dynamic, v_format);
with (obj_mutton) event_perform(ev_draw, 0);
vertex_end(v_dynamic);
_tex = sprite_get_texture(spr_mutton, 0);
vertex_submit(v_dynamic, pr_trianglelist, _tex);

gpu_set_ztestenable(false);
gpu_set_zwriteenable(false);
gpu_set_alphatestenable(false);