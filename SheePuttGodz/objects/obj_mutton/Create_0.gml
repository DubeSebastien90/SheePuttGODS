walkspd = 0.1

dx = 0
dy = 0
dz = 0

function _try_move(dx, dy, dz) {
    var applied_dx = 0;
    var applied_dy = 0;
	
	var grid_pos = obj_grid._world_pos_to_tile(x,y)
	
	var grid_x = grid_pos.x
	var grid_y = grid_pos.y
	
	var r = 0.2;
    
    if (dx != 0) {
        var test_x = grid_x + dx;
        var edge_x = test_x + sign(dx) * r;
        // les deux coins sur Y (haut et bas de la hitbox)
        var corner_y_top = grid_y - r;
        var corner_y_bot = grid_y + r;
        
        if (obj_grid._is_walkable(floor(edge_x), floor(corner_y_top))
         && obj_grid._is_walkable(floor(edge_x), floor(corner_y_bot))) {
            applied_dx = dx;
        }
    }
    
    // Axe Y : pareil dans l'autre sens
    if (dy != 0) {
        var test_y = grid_y + dy;
        var edge_y = test_y + sign(dy) * r;
        var corner_x_left  = grid_x - r;
        var corner_x_right = grid_x + r;
        
        if (obj_grid._is_walkable(floor(corner_x_left),  floor(edge_y))
         && obj_grid._is_walkable(floor(corner_x_right), floor(edge_y))) {
            applied_dy = dy;
        }
    }
 
    return {dx: applied_dx, dy: applied_dy, dz: dz};
}