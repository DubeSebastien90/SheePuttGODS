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
        draw_sprite_ext(spr_feet, image_index, impact.x, impact.y - height_offset, 1, 1, 0, c_white, 1);
    break;
}
