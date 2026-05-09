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


var collisions_d = (_try_move(dx, dy, dz))

scaredTime -= 1

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
depth = -bbox_bottom
