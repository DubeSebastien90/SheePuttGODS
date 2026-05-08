// 1. Calculate the Delta Multiplier
// 1,000,000 microseconds / 60 FPS = 16666.66. 
// _dt will be 1.0 at 60 FPS, 2.0 at 30 FPS, and 0.41 at 144 FPS.
var _dt = delta_time / 16666.66;

var input_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var input_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// 2. Acceleration & Gravity (Linear: Multiply by _dt)
vx += (input_x + input_y) * walkspd * _dt;
vy += (input_y - input_x) * walkspd * _dt;
vz -= grav * _dt;

on_ground = (gz <= 0 && vz <= 0);
if (on_ground) { 
    vz = 0; 
    gz = 0; 
}

// 3. Jumping (Instant Force: Do NOT multiply by _dt)
if (keyboard_check_pressed(vk_space) && on_ground) {
    vz = jump_force;
}

// 4. Friction (Exponential Decay: Must use power() function)
if (on_ground) {
    var _fric_dt = power(friction, _dt);
    vx *= _fric_dt;
    vy *= _fric_dt;
}

// 5. Max Speed Clamp (Clamp the raw velocity, no _dt needed here)
var spd = point_distance(0, 0, vx, vy);
if (spd > walkspd) {
    vx = (vx / spd) * walkspd;
    vy = (vy / spd) * walkspd;
}

// 6. Apply Velocity to Position (Multiply by _dt for the actual move)
var _move_x = vx * _dt;
var _move_y = vy * _dt;
var _move_z = vz * _dt;

var nx = gx + _move_x;
if (is_walkable(floor(nx + sign(vx) * 0.2), floor(gy - 0.2))
&&  is_walkable(floor(nx + sign(vx) * 0.2), floor(gy + 0.2))) {
    gx = nx;
} else {
    vx = 0;
}

var ny = gy + _move_y;
if (is_walkable(floor(gx - 0.2), floor(ny + sign(vy) * 0.2))
&&  is_walkable(floor(gx + 0.2), floor(ny + sign(vy) * 0.2))) {
    gy = ny;
} else {
    vy = 0;
}

gz += _move_z;
if (gz < 0) gz = 0;
    
show_debug_message({gx, gy, gz});