draw_sprite_ext(spr_splash,0,room_width/2,room_height/2,11.5,11.5,0,c_white,1)

draw_set_font(fnt_pixel)
draw_set_valign(fa_center)
draw_set_halign(fa_center)
draw_set_colour(c_black)
draw_text_transformed(room_width/2, room_height/2, "Press any key to start", 3,3,0)

//draw_sprite_ext(spr_water_part,2,room_width/2,room_height/2,1000,1000,0,c_white,1)
//for (var i = 0; i < 12; i++) {
//    var _x = (room_width / 12) * (i + 0.5)
//    draw_sprite_ext(spr_mutton_air, i, _x, room_height / 2, 6, 6, 0, c_white, 1)
//}