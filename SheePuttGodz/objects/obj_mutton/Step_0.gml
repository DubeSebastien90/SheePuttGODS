press_up = keyboard_check(ord("W"))
press_left = keyboard_check(ord("A"))
press_down = keyboard_check(ord("S"))
press_right = keyboard_check(ord("D"))

var input_x = press_right - press_left;  // -1, 0, ou +1 (axe écran)
var input_y = press_down  - press_up;    // -1, 0, ou +1 (axe écran)

// Conversion écran → grille
var dx = (input_x + input_y) * walkspd;
var dy = (input_y - input_x) * walkspd;

var collisions_d = (_try_move(dx, dy, dz))

screen_d = obj_grid._iso_vec_to_screen(collisions_d.dx,collisions_d.dy,collisions_d.dz)

x += screen_d.x
y += screen_d.y