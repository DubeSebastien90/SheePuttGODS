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
