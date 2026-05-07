lifetime--;
if lifetime <= 0 instance_destroy(self);

if lifetime <= start_fading {
    image_alpha = lifetime / start_fading
}

draw_sprite_ext(spr_footprint, 0, x, y, 1, 1, 0, c_white, image_alpha);
