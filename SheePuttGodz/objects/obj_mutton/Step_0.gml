press_up = keyboard_check(ord("W"))
press_left = keyboard_check(ord("A"))
press_down = keyboard_check(ord("S"))
press_right = keyboard_check(ord("D"))

press_jump = keyboard_check_pressed(vk_space)

var input_x = press_right - press_left;
var input_y = press_down  - press_up;   

// Conversion écran → grille
if canControl{
dx = (input_x + input_y) * walkspd;
dy = (input_y - input_x) * walkspd;
}

dz -= grav;

//collisions
grid_pos = obj_grid._world_pos_to_tile(x, y);
grid_x = grid_pos.x;
grid_y = grid_pos.y;

on_land  = obj_grid.is_walkable(floor(grid_x), floor(grid_y));
on_water = obj_grid.is_swimable(floor(grid_x), floor(grid_y));

if (press_jump && z <= 0 && on_land) && canControl{
    dz = jumpForce;
	in_air = true
}

//wandering
if !footMovement{
	if wandering{
		wanderingCooldown -= 1
		if wanderingCooldown < 0{
			waitingCooldown = waitingCooldownMax  + random_range(-3*60,3*60)
			wandering = false
		}
		dx = (dirStandingPos.x - myStandingPos.x)*spdWander
		dy = (dirStandingPos.y - myStandingPos.y)*spdWander
	} else {
		waitingCooldown -= 1
		if waitingCooldown < 0{
			wanderingCooldown = wanderingCooldownMax + random_range(-30,30)
			wandering = true
			dirStandingPos = {
				x: myStandingPos.x + random_range(-tileWanderingDistMax,tileWanderingDistMax), 
				y: myStandingPos.y + random_range(-tileWanderingDistMax,tileWanderingDistMax)
			}
		}
		
		var _dist = sqrt(sqr(grid_x - dirStandingPos.x) + sqr(grid_y - dirStandingPos.y))
		spdWander = _dist / wanderingCooldown
	}
} else if footMovement{
	if scaredTime < 0 {
		var _speed = sqrt(dx * dx + dy * dy);
		if _speed < 0.01{
			wandering = false
			myStandingPos = {x:grid_x,y:grid_y}
			wanderingCooldown = wanderingCooldownMax + random_range(-60,60)
			waitingCooldown = waitingCooldownMax  + random_range(-60,60)
			footMovement = false
		}
	}
}

var total_push_x = 0;
var total_push_y = 0;
var total_push_z = 0;
var max_zn = 0;
var hit_count = 0;

//=============Bumper================
with (obj_bumper) {
    if (abs(tile_i - other.grid_x) > 2 || abs(tile_j - other.grid_y) > 2) continue;

    var _dist_3d = point_distance_3d(tile_i, tile_j, 0, other.grid_x, other.grid_y, other.z);
    var bumper_radius = 0.8;

    if (_dist_3d < bumper_radius) {
        _dist_3d = (_dist_3d == 0) ? 0.01 : _dist_3d;

        var _xn = (other.grid_x - tile_i) / _dist_3d;
        var _yn = (other.grid_y - tile_j) / _dist_3d;
        var _zn = max(1, other.z / _dist_3d);

        var overlap = bumper_radius - _dist_3d;

        total_push_x += _xn * overlap;
        total_push_y += _yn * overlap;
        total_push_z += _zn * overlap;

        max_zn = max(max_zn, _zn);
        hit_count++;
    }
}

if (hit_count > 0) {
    grid_x += total_push_x;
    grid_y += total_push_y;
    z += total_push_z;

    var push_screen = obj_grid._iso_vec_to_screen(total_push_x, total_push_y);
    x += push_screen.x;
    y += push_screen.y;

    var combined_dist = point_distance(0, 0, total_push_x, total_push_y);
    combined_dist = (combined_dist == 0) ? 0.01 : combined_dist;

    var final_nx = total_push_x / combined_dist;
    var final_ny = total_push_y / combined_dist;

    var bounce_force = 0.05;

    dx = final_nx * bounce_force;
    dy = final_ny * bounce_force;
    dz = max_zn * bounce_force;

    in_air = true;
}

var collisions_d = (_try_move(dx, dy, dz))

scaredTime -= 1

if on_water{
	scaredTime = -1
	slowing = water_slowing
}

screen_d = obj_grid._iso_vec_to_screen(collisions_d.dx,collisions_d.dy)
z += collisions_d.dz;

if (collisions_d.dz == 0 && dz < 0) {
	if in_air = true{
    dz = 0;
	} else if scaredTime < 0{
		var _speed = sqrt(dx * dx + dy * dy);
        
        if (_speed > 0) {
            // Direction unitaire
            var dir_x = dx / _speed;
            var dir_y = dy / _speed;
            
            // Réduire la vitesse
            var new_speed = max(0, _speed - slowing);
            
            // Recomposer
            dx = dir_x * new_speed;
            dy = dir_y * new_speed;
		}
	}
    z = 0;
	in_air = false
}

x += screen_d.x
y += screen_d.y

//layers
if !mort{
depth = -bbox_bottom
}

if !in_air{
	if  collisions_d.dx !=0 ||  collisions_d.dy !=0{
		tempsRot += 5 +(sqrt( collisions_d.dx* collisions_d.dx +  collisions_d.dy* collisions_d.dy)*50)
		rot = dsin(tempsRot) * 10
	} else{
		tempsRot = 0
		rot = lerp(rot,0,0.1)
	}
}