if shockwave_ready {
    shockwave_spr_idx += shockwave_speed;
    draw_sprite(spr_shockwave, floor(shockwave_spr_idx), impact.x, impact.y);
    
    if shockwave_spr_idx > 6 {
        shockwave_ready = false;
    }
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
        draw_sprite_ext(
            spr_foot_shadow, 0,
            impact.x, impact.y,
            shadow_size,
            shadow_size,
            0,
            make_colour_rgb(30, 50, 20),
            shadow_alpha
        );
        
        draw_sprite_ext(spr_foot, image_index, impact.x, impact.y - height_offset, 1, 1, 0, c_white, 1);
    break;
}
