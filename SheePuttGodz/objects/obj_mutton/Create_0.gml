walkspd = 0.02

dx = 0
dy = 0
dz = 0

z = 0
jumpForce = 1
grav = 0.05

on_land = false
on_water = false
in_air = false

water_offset = 4
depth_offset = 6
collision_offset = 3

offset_origin = 4

grid_x = -1
grid_y = -1

canControl = false

slowing = 0.001
water_slowing = 0.005
scaredTime = 3
scaredMaxTime = 30

rot = 0
tempsRot = 0

_spin_index = 0
spin_speed = 0.4
spin_side = 1

myStandingPos = {x:0,y:0}
dirStandingPos = {x:0,y:0}
wanderingCooldownMax = 60
wanderingCooldown = 0
waitingCooldown = 0
waitingCooldownMax = 60*4
tileWanderingDistMax = 0.5
wandering = false
spdWander = 0
footMovement = true

function _try_move(dx, dy, dz) {
    var applied_dx = 0;
    var applied_dy = 0;
    var applied_dz = 0;
	
	if (in_air) {
        applied_dx = dx;
        applied_dy = dy;
    } else {
        var _can_enter = function(tx, ty) {
            if (on_land  && obj_grid.is_walkable(tx, ty)) return true;
            if (on_water && obj_grid.is_swimable(tx, ty)) return true;
            return false;
        };
        
        var r = 0.4;
        
        // Axe X
        if (dx != 0) {
            var test_x = grid_x + dx;
            var edge_x = test_x + sign(dx) * r;
            var corner_y_top = grid_y - r;
            var corner_y_bot = grid_y + r;
            
            if (_can_enter(floor(edge_x), floor(corner_y_top))
             && _can_enter(floor(edge_x), floor(corner_y_bot))) {
                applied_dx = dx;
            }
        }
        
        // Axe Y
        if (dy != 0) {
            var test_y = grid_y + dy;
            var edge_y = test_y + sign(dy) * r;
            var corner_x_left  = grid_x - r;
            var corner_x_right = grid_x + r;
            
            if (_can_enter(floor(corner_x_left),  floor(edge_y))
             && _can_enter(floor(corner_x_right), floor(edge_y))) {
                applied_dy = dy;
            }
        }
        
        // ----- BORDER PUSH -----
        // After applying movement, check if any corner straddles the wrong tile type.
        // If so, push gently back toward our home tile.
        var _is_home = function(tx, ty) {
            if (on_land)  return obj_grid.is_walkable(tx, ty);
            if (on_water) return obj_grid.is_swimable(tx, ty);
            return true;
        };
        
        var pushStrength = 0.05; // tiles per step — tune to taste
        
        var nx = grid_x + applied_dx;
        var ny = grid_y + applied_dy;
        
        // Sample the four corners of the collision box
        var corners = [
            {x: nx - r, y: ny - r, sx: -1, sy: -1}, // top-left
            {x: nx + r, y: ny - r, sx:  1, sy: -1}, // top-right
            {x: nx - r, y: ny + r, sx: -1, sy:  1}, // bot-left
            {x: nx + r, y: ny + r, sx:  1, sy:  1}, // bot-right
        ];
        
        var push_x = 0;
        var push_y = 0;
        
        for (var i = 0; i < array_length(corners); i++) {
            var c = corners[i];
            if (!_is_home(floor(c.x), floor(c.y))) {
                // this corner is on the wrong tile type — push away from it
                push_x -= c.sx;
                push_y -= c.sy;
            }
        }
        
        // Normalize and apply the push (so two corners on the same side don't double-push)
        if (push_x != 0) applied_dx += sign(push_x) * pushStrength;
        if (push_y != 0) applied_dy += sign(push_y) * pushStrength;
    }
    // Axe Z
    if (z + dz < 0) {
        applied_dz = -z;
    } else {
        applied_dz = dz;
    }
    
    return {dx: applied_dx, dy: applied_dy, dz: applied_dz};
}

mort = false

function stomped(){
	mort = true
	dx = 0
	dy = 0
	depth = 199
}

function isInWinnableTile(){
	if !in_air && !mort{
	with(obj_end_gate){
		if (tile_i = floor(other.grid_x) && tile_j = floor(other.grid_y)){
			return true
		}
	}
	}
	return false
}