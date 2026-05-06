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

function _try_move(dx, dy, dz) {
    var applied_dx = 0;
    var applied_dy = 0;
    var applied_dz = 0;
	
	if (in_air) {
        applied_dx = dx;
        applied_dy = dy;
    } else {
    // Fonction locale : une tuile est-elle traversable selon mon mode actuel ?
    var _can_enter = function(tx, ty) {
        if (on_land  && obj_grid.is_walkable(tx, ty)) return true;
        if (on_water && obj_grid.is_swimable(tx, ty)) return true;
        return false;
    };
    
    var r = 0.2;
    
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
	}
    // Axe Z
    if (z + dz < 0) {
        applied_dz = -z;
		in_air = false
    } else {
        applied_dz = dz;
    }
    
    return {dx: applied_dx, dy: applied_dy, dz: applied_dz};
}