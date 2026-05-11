draw_sprite_ext(spr_splash,0,room_width/2,room_height/2,11.5,11.5,0,c_white,1)

draw_set_font(fnt_pixel)
draw_set_valign(fa_center)
draw_set_halign(fa_center)
draw_set_colour(c_black)
draw_text_transformed(room_width/2, room_height/2, "Press any key to start", 3,3,0)