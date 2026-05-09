var press_up = keyboard_check(ord("W"));
var press_left = keyboard_check(ord("A"));
var press_down = keyboard_check(ord("S"));
var press_right = keyboard_check(ord("D"));
var press_jump = keyboard_check_pressed(vk_space);

var input_x = press_right - press_left;
var input_y = press_down  - press_up;

if (canControl) {
    vx = (input_x + input_y) * walkspd;
    vy = (input_y - input_x) * walkspd;
} else {
    vx = 0;
    vy = 0;
}

vz -= grav;

if (press_jump && !in_air && on_land && canControl) {
    vz = jumpForce;
    in_air = true;
}

var move = _try_move(vx, vy, vz);

gx += move.vx;
gy += move.vy;
gz += move.vz;

if (move.landed && vz < 0) {
    vx     = 0;
    vy     = 0;
    vz     = 0;
    in_air = false;
}

on_land  = _is_walkable(floor(gx), floor(gy));
on_water = _is_swimable(floor(gx), floor(gy));

if (on_water) gz -= 0.5;