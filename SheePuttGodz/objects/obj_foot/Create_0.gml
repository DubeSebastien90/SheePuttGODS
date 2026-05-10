max_speed = 10;
acceleration = 0.5;
pre_impact_dist = 10;
start_height  = 200;
stomp_hold_max = 30;

state = "marking"
impact = { x: -1, y: -1 };
impact_on_grid = { x: -1, y: -1 };
spr_index = spr_marker;
speed = 0;
height_offset = 0;
stomp_hold = 0;

clouds_active = false;
clouds_spr_idx = 0;
clouds_speed = 0.45;

max_force_repulsion = 0.12;
max_jump_dist = 2
max_repulsion_dist = 4
distStomp = 0.7

shockwave_active = false;
shockwave_time = 0;
shockwave_expand = 2;
shockwave_duration = 20;
shockwave_delay = 5;
shockwave_segments = 20;
shockwave_wobble_amp = 0.12;
shockwave_wobble_freq = 6;

origin_ofsset_y = 6

draw_wobbly_ring = function(cx, cy, radius, alpha) {
    draw_set_alpha(alpha);
    for (var s = 0; s < shockwave_segments; s++) {
        var a1 = (s / shockwave_segments) * 2 * pi;
        var a2 = ((s + 1) / shockwave_segments) * 2 * pi;

        var w1 = 1 + sin(a1 * shockwave_wobble_freq) * shockwave_wobble_amp;
        var w2 = 1 + sin(a2 * shockwave_wobble_freq) * shockwave_wobble_amp;

        draw_line(
            cx + cos(a1) * radius * w1,
            cy + sin(a1) * radius * w1 * 0.5,
            cx + cos(a2) * radius * w2,
            cy + sin(a2) * radius * w2 * 0.5
        );
    }
};

myOmbre = instance_create_layer(x,y,"dessus",obj_foot_ombre)
