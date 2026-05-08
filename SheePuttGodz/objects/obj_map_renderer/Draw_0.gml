if (v_buffer_solid == undefined) exit;
    
var _tex = sprite_get_texture(spr_tiles, 0);

if (solid_exists) vertex_submit(v_buffer_solid, pr_trianglelist, _tex);
if (water_exists) {
    shader_set(shd_water);
    shader_set_uniform_f(u_time, current_time / 1000);
    vertex_submit(v_buffer_water, pr_trianglelist, _tex);
    shader_reset();
}