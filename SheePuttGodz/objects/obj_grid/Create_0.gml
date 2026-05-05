randomize()

current_level = 0
tile_selected = {x: -1, y: -1}

levels = get_levels()
grid = levels[0];

tile_w = sprite_get_width(spr_tile) / 2;
tile_h = sprite_get_height(spr_tile) / 4;
grid_origin_x = room_width  / 2;
grid_origin_y = (room_height / 2) - (grid.height * tile_h);

function game_pos_to_screen_pos(game_x, game_y) {
    var screen_x = (game_x - obj_camera.x) / obj_camera.zoom_ammount + obj_camera.camW / 2;
    var screen_y = (game_y - obj_camera.y) / obj_camera.zoom_ammount + obj_camera.camH / 2;
    return {
        x : screen_x,
        y : screen_y
    };
}

function screen_pos_to_game_pos(screen_x, screen_y){
    var game_x = obj_camera.x - (obj_camera.camW/2 - screen_x)*obj_camera.zoom_ammount;
    var game_y = obj_camera.y - (obj_camera.camH/2 - screen_y)*obj_camera.zoom_ammount;
    return {
        x : game_x,
        y : game_y
    };
}

function get_selected_tile(mx, my) {
    var dx = mx - grid_origin_x;
    var dy = my - grid_origin_y;

    var grid_x = (dx / tile_w + dy / tile_h) * 0.5;
    var grid_y = (dy / tile_h - dx / tile_w) * 0.5;

    return {
        x: floor(grid_x),
        y: floor(grid_y)
    };
}

function _tile_to_world_pos(grid_x, grid_y) {
    var world_x = (grid_x - grid_y) * tile_w;
    var world_y = (grid_y + grid_x) * tile_h;

    world_x += grid_origin_x;
    world_y += grid_origin_y;

    return {x: world_x, y: world_y};
}
