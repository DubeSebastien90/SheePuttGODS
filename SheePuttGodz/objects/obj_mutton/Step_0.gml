// 1. Delta Time Multiplier (1.0 at 60fps)
var _dt = delta_time / 16666.66;

// 2. Input
var input_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var input_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// 3. Acceleration & Gravity
vx += (input_x + input_y) * walkspd * _dt;
vy += (input_y - input_x) * walkspd * _dt;
vz -= grav * _dt;

on_ground = (gz <= 0 && vz <= 0);
if (on_ground) { 
    vz = 0; 
    gz = 0; 
}

// 4. Jumping
if (keyboard_check_pressed(vk_space) && on_ground) {
    vz = jump_force;
}

// 5. Friction (Delta-time corrected using power)
if (on_ground) {
    var _fric_dt = power(friction, _dt);
    vx *= _fric_dt;
    vy *= _fric_dt;
}

// 6. Max Speed Clamp
var spd = point_distance(0, 0, vx, vy);
if (spd > walkspd) {
    vx = (vx / spd) * walkspd;
    vy = (vy / spd) * walkspd;
}

// 7. Calculate Actual Movement
var _move_x = vx * _dt;
var _move_y = vy * _dt;
var _move_z = vz * _dt;

// 8. X-Axis Collision
var nx = gx + _move_x;
if (is_walkable(floor(nx + sign(vx) * 0.2), floor(gy - 0.2)) && 
    is_walkable(floor(nx + sign(vx) * 0.2), floor(gy + 0.2))) {
    gx = nx;
} else {
    vx = 0;
}

// 9. Y-Axis Collision
var ny = gy + _move_y;
if (is_walkable(floor(gx - 0.2), floor(ny + sign(vy) * 0.2)) && 
    is_walkable(floor(gx + 0.2), floor(ny + sign(vy) * 0.2))) {
    gy = ny;
} else {
    vy = 0;
}

// 10. Z-Axis (Verticality)
gz += _move_z;
if (gz < 0) gz = 0;
    
show_debug_message({gx, gy, gz})