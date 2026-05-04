randomize()

current_level = 0
tile_selected = {x: -1, y: -1}

// Tile char map:  . = grass  ~ = water  # = bridge  = = deep water
level_data = [

    // Level 0 — straight fairway
    [
        "~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~",
        "~~~~.......~~~~~",
        "~~~.........~~~~",
        "~~...........~~~",
        "~~...........~~~",
        "~~...........~~~",
        "~~...........~~~",
        "~~...........~~~",
        "~~...........~~~",
        "~~...........~~~",
        "~~...........~~~",
        "~~~.........~~~~",
        "~~~~.......~~~~~",
        "~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~",
    ],

    // Level 1 — Z-shaped dogleg
    [
        "~~~~~~~~~~~~~~~~",
        "~..........~~~~~",
        "~..........~~~~~",
        "~..........~~~~~",
        "~..........~~~~~",
        "~..........~~~~~",
        "~~~~~~.....~~~~~",
        "~~~~~~.....~~~~~",
        "~~~~~~.....~~~~~",
        "~~~~~~.....~~~~~",
        "~~~~~~.....~~~~~",
        "~~~~~~~~~~.....~",
        "~~~~~~~~~~.....~",
        "~~~~~~~~~~.....~",
        "~~~~~~~~~~.....~",
        "~~~~~~~~~~~~~~~~",
    ],

    // Level 2 — island green with bridges
    [
        "~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~",
        "~~.........~~~~~",
        "~~.........~~~~~",
        "~~...##.##..~~~~",
        "~~...#.....~~~~~",
        "~~...#.....~~~~~",
        "~~...##.##..~~~~",
        "~~.........~~~~~",
        "~~.........~~~~~",
        "~~.........~~~~~",
        "~~.........~~~~~",
        "~~~.........~~~~",
        "~~~~.......~~~~~",
        "~~~~~~~~~~~~~~~~",
        "~~~~~~~~~~~~~~~~",
    ],

];

function _char_to_tile(c) {
    switch (c) {
        case ".": return 0;
        case "~": return 6;
        case "#": return 7;
        case "=": return 8;
        default:  return 0;
    }
}

function load_level(index) {
    var rows = level_data[index];
    var lh   = array_length(rows);
    var lw   = string_length(rows[0]);

    height = lh;
    width  = lw;

    tile_w = sprite_get_width(spr) / 2;
    tile_h = sprite_get_height(spr) / 4;
    grid_origin_x = room_width  / 2;
    grid_origin_y = (room_height / 2) - (height * tile_h);
	grid = noone
	gridDeco = noone

    if ds_exists(grid,     ds_type_grid) ds_grid_destroy(grid);
    if ds_exists(gridDeco, ds_type_grid) ds_grid_destroy(gridDeco);

    grid     = ds_grid_create(width, height);
    gridDeco = ds_grid_create(width, height);

    for (var j = 0; j < height; j++) {
        var row = rows[j];
        for (var i = 0; i < width; i++) {
            var c   = string_char_at(row, i + 1); // GML strings are 1-indexed
            var val = _char_to_tile(c);
            ds_grid_set(grid, i, j, {value: val, _id: -1});

            var deco = random_range(0, 1);
            if deco > 0.95 {
                deco = choose(1, 2, 3);
            } else deco = 0;
            ds_grid_set(gridDeco, i, j, {value: deco, _id: -1});
        }
    }

    tile_selected = {x: -1, y: -1};
}

function game_pos_to_screen_pos(game_x, game_y) {
    var screen_x = (game_x - obj_camera.x) / obj_camera.zoom_ammount + obj_camera.camW / 2;
    var screen_y = (game_y - obj_camera.y) / obj_camera.zoom_ammount + obj_camera.camH / 2;
    return [screen_x, screen_y];
}

function screen_pos_to_game_pos(screen_x, screen_y){
    var game_x = obj_camera.x - (obj_camera.camW/2 - screen_x)*obj_camera.zoom_ammount;
    var game_y = obj_camera.y - (obj_camera.camH/2 - screen_y)*obj_camera.zoom_ammount;
    return [game_x, game_y];
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

function get_sub_bridge(i, j){
    var bottom_left  = {value:6,_id:noone};
    var bottom_right = {value:6,_id:noone};
    var up_left      = {value:6,_id:noone};
    var up_right     = {value:6,_id:noone};

    if i == 0          { up_left      = {value:6,_id:noone}; } else up_left      = ds_grid_get(grid, i-1, j);
    if j == 0          { up_right     = {value:6,_id:noone}; } else up_right     = ds_grid_get(grid, i, j-1);
    if i == width - 1  { bottom_right = {value:6,_id:noone}; } else bottom_right = ds_grid_get(grid, i+1, j);
    if j == height - 1 { bottom_left  = {value:6,_id:noone}; } else bottom_left  = ds_grid_get(grid, i, j+1);

    if (bottom_left.value != 6 && bottom_right.value != 6 && up_left.value != 6 && up_right.value != 6) return 6;
    if (bottom_left.value != 6 && up_left.value != 6 && up_right.value != 6)   return 5;
    if (bottom_right.value != 6 && up_left.value != 6 && up_right.value != 6)  return 4;
    if (bottom_left.value != 6 && bottom_right.value != 6 && up_right.value != 6) return 3;
    if (bottom_left.value != 6 && bottom_right.value != 6 && up_left.value != 6)  return 2;
    if (bottom_left.value != 6 && up_left.value != 6 && bottom_right.value == 6 && up_right.value == 6) return 7;
    if (bottom_left.value == 6 && up_left.value == 6 && bottom_right.value != 6 && up_right.value != 6) return 8;
    if (bottom_left.value != 6 && up_left.value == 6 && bottom_right.value != 6 && up_right.value == 6) return 9;
    if (bottom_left.value == 6 && up_left.value != 6 && bottom_right.value == 6 && up_right.value != 6) return 10;
    if (bottom_left.value  != 6) return 0;
    if (up_right.value     != 6) return 0;
    if (bottom_right.value != 6) return 1;
    if (up_left.value      != 6) return 1;

    return 0;
}

load_level(0);
