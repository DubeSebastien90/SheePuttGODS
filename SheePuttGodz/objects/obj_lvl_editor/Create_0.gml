var _spr = spr_level_map;
var _w = sprite_get_width(_spr);
var _h = sprite_get_height(_spr);
var _total_frames = sprite_get_number(_spr) - 1;

var _surf = surface_create(_w, _h);
for (var i = 0; i < _total_frames; i++) {
    surface_set_target(_surf);
    draw_clear_alpha(c_black, 0);
    draw_sprite(_spr, i, 0, 0);
    surface_reset_target();

    show_debug_message("[");
    
    for (var _y = 0; _y < _h; _y++) {
        var _row_string = "    \""; 
        
        for (var _x = 0; _x < _w; _x++) {
            var _color = surface_getpixel(_surf, _x, _y);
            var _char = " ";
            
            switch (_color) {
                case make_colour_rgb(77,155,230): _char = "~"; break; // Water
                case make_colour_rgb(30,188,115): _char = "."; break; // Floor
                case make_colour_rgb(62,53,70): _char = "="; break; // void
                case c_white: _char = "m"; break; // Mutton
                case make_colour_rgb(232,59,59): _char = "v"; break; // Wolf
                case make_color_rgb(251,255,134): _char = "e"; break; // Objective 
                case make_colour_rgb(141,244,222): _char = "w"; break; // Water objective
                case make_colour_rgb(144,94,169): _char = "b"; break; // Bumper
            }
            _row_string += _char; 
        }
        _row_string += "\","; 
        show_debug_message(_row_string); 
    }
    
    show_debug_message("],");
}

surface_free(_surf);

game_end()