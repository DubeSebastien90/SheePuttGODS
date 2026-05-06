randomize()

current_level = 0
levels = get_levels()
level = levels[0];

tile_w = sprite_get_width(spr_tile) / 2;
tile_h = sprite_get_height(spr_tile) / 4;
tile_h_vertical = 2 * tile_h
grid_origin_x = room_width  / 2;
grid_origin_y = (room_height / 2) - (level.height * tile_h);

function room_pos_to_game_pos(room_x, room_y) {
    var dx = room_x - grid_origin_x;
    var dy = room_y - grid_origin_y;

    var grid_x = (dx / tile_w + dy / tile_h) * 0.5 - 1;
    var grid_y = (dy / tile_h - dx / tile_w) * 0.5;

    return {
        x: grid_x,
        y: grid_y
    };
}

function game_pos_to_room_pos(game_x, game_y) {
    var room_x = (game_x - game_y) * tile_w;
    var room_y = (game_x + game_y) * tile_h;

    room_x += grid_origin_x;
    room_y += grid_origin_y;

    return {
        x: room_x,
        y: room_y
    };
}

function is_land(game_x, game_y) {
    var floor_x = floor(game_x + 0.35)
    var floor_y = floor(game_y + 0.35)
    
    if  (floor_x < 0 || 
        floor_x >= level.width ||
        floor_y < 0 ||
        floor_y >= level.height) {
            return false;
        }
        
    var value = ds_grid_get(level.grid, floor_x, floor_y);
    return value > 0 && value < 5;
}

function _iso_vec_to_screen(dx, dy) {
    var screen_dx = (dx - dy) * tile_w;
    var screen_dy = (dx + dy) * tile_h;
    return {x: screen_dx, y: screen_dy};
}

function _world_pos_to_tile(world_x, world_y) {
    var wx = world_x - grid_origin_x;
    var wy = world_y - grid_origin_y;
    var grid_x = (wx / tile_w + wy / tile_h) / 2;
    var grid_y = (wy / tile_h - wx / tile_w) / 2;
    return {x: grid_x, y: grid_y};
}

WALKABLE_TILES = [1,2,3,4]

function _is_walkable(tile_x, tile_y) {
    // Vérifier les bornes de la grille
    if (tile_x < 0 || tile_y < 0) return false;
    if (tile_x >= ds_grid_width(level.grid) || tile_y >= ds_grid_height(level.grid)) return false;
    
    // Récupérer la valeur de la tuile
    var value = ds_grid_get(level.grid, tile_x, tile_y);
    return array_contains(WALKABLE_TILES, value);
}
