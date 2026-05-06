press_up = keyboard_check(ord("W"))
press_left = keyboard_check(ord("A"))
press_down = keyboard_check(ord("S"))
press_right = keyboard_check(ord("D"))

press_jump = keyboard_check_pressed(ord("Q"))

var input_x = press_right - press_left;
var input_y = press_down  - press_up;   

// Conversion écran → grille
dx = (input_x + input_y) * walkspd;
dy = (input_y - input_x) * walkspd;

dz -= grav;
if (press_jump && z <= 0) {
    dz = jumpForce;
}

if press_jump && z == 0{
	dz = jumpForce;
}

var collisions_d = (_try_move(dx, dy, dz))

screen_d = obj_grid._iso_vec_to_screen(collisions_d.dx,collisions_d.dy)
z += collisions_d.dz;

x += screen_d.x
y += screen_d.y


if (collisions_d.dz == 0 && dz < 0) {
    dz = 0;
    z = 0;  // au cas où on est légèrement sous 0
}