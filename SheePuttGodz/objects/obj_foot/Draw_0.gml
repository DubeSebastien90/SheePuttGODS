if clouds_active {
    clouds_spr_idx += clouds_speed;
    draw_sprite(spr_shockwave, floor(clouds_spr_idx), impact.x, impact.y);
    
    if clouds_spr_idx > 6 {
        clouds_active = false;
    }
}

if (shockwave_active) {
    shockwave_time++;

    var r1 = shockwave_time * shockwave_expand;
    var a1 = max(0, 1 - shockwave_time / shockwave_duration);
    draw_wobbly_ring(impact.x, impact.y, r1, a1);

    if (shockwave_time >= shockwave_delay) {
        var t2 = shockwave_time - shockwave_delay;
        draw_wobbly_ring(impact.x, impact.y, t2 * shockwave_expand, max(0, 1 - t2 / shockwave_duration));
    }

    draw_set_alpha(1);
    if (shockwave_time >= shockwave_duration + shockwave_delay) shockwave_active = false;
}

switch (state) {
    case "marking":
        if (x >= 0 && y >= 0) {
            draw_sprite_ext(spr_marker, 0, x, y, 1, 1, 0, c_white, 0.8);
        }
    break;

    default:
        var t = 1 - (height_offset / start_height);
        var shadow_size  = lerp(2, 0.5, t);
        var shadow_alpha = lerp(0.0, 0.8, t);
		with(myOmbre){
        draw_sprite_ext(
            spr_foot_shadow, 0,
            other.impact.x, other.impact.y,
            shadow_size,
            shadow_size,
            0,
            make_colour_rgb(30, 50, 20),
            shadow_alpha
        );
		}
        
        draw_sprite_ext(spr_foot, image_index, impact.x, impact.y - height_offset, 1, 1, 0, c_white, 1);
    break;
}
