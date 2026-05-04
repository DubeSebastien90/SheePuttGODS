randomize()

grid = ds_grid_create(width, height);
for (var i = 0; i < width; i++) {
    for (var j = 0; j < height; j++) {
        ds_grid_set(grid, i, j, {value: 0, _id: -1});
    }
}

gridDeco = ds_grid_create(width, height);
for (var i = 0; i < width; i++) {
    for (var j = 0; j < height; j++) {
        var decorated = random_range(0,1)
        if decorated > 0.95{
            decorated = choose(1,2,3)
        } else decorated = 0
        ds_grid_set(gridDeco, i, j, {value: decorated, _id: -1});
    }
}

if width % 4 != 0 || height % 4 != 0 {throw "The grid sizes need to be multiple of 4"}

tile_selected = {x: -1, y: -1}

spacing = 1
tile_w = sprite_get_width(spr) / 2;
tile_h = sprite_get_height(spr) / 4

grid_origin_x = room_width / 2
grid_origin_y = (room_height / 2) - (height * tile_h)

function game_pos_to_screen_pos(game_x, game_y) {
    var screen_x = (game_x - obj_camera.x) / obj_camera.zoom_ammount + obj_camera.camW / 2;
    var screen_y = (game_y - obj_camera.y) / obj_camera.zoom_ammount + obj_camera.camH / 2;
    return [screen_x, screen_y];
}

function screen_pos_to_game_pos(screen_x, screen_y){
    var game_x = obj_camera.x - (obj_camera.camW/2 - screen_x)*obj_camera.zoom_ammount
    var game_y = obj_camera.y - (obj_camera.camH/2 - screen_y)*obj_camera.zoom_ammount
    return [game_x, game_y]
}

function get_selected_tile(mx, my) {
    var dx = mx - grid_origin_x
    var dy = my - grid_origin_y

    var grid_x = (dx / tile_w + dy / tile_h) * 0.5;
    var grid_y = (dy / tile_h - dx / tile_w) * 0.5;

    return {
        x: floor(grid_x),
        y: floor(grid_y)
    };
}

function _tile_to_world_pos(grid_x, grid_y) {
    var world_x = (grid_x - grid_y) * tile_w
    var world_y = (grid_y + grid_x) * tile_h

    world_x += grid_origin_x;
    world_y += grid_origin_y;

    return {x: world_x, y: world_y};
}

function get_sub_bridge(i, j){
    var bottom_left = {value:6,_id:noone}
    var bottom_right = {value:6,_id:noone}
    var up_left  = {value:6,_id:noone}
    var up_right = {value:6,_id:noone}

    if i == 0{
        up_left =  {value:6,_id:noone}
    } else up_left = ds_grid_get(grid, i-1, j)
    if j == 0{
        up_right =  {value:6,_id:noone}
    } else up_right = ds_grid_get(grid, i, j-1)
    if i == width - 1{
        bottom_right =  {value:6,_id:noone}
    } else bottom_right = ds_grid_get(grid, i+1, j)
    if j == height -1{
        bottom_left =  {value:6,_id:noone}
    } else bottom_left = ds_grid_get(grid, i, j+1)

    if (bottom_left.value != 6 && bottom_right.value != 6 && up_left.value != 6 && up_right.value != 6){
        return 6
    }

    if (bottom_left.value != 6 && up_left.value != 6 && up_right.value != 6){
        return 5
    }

    if (bottom_right.value != 6 && up_left.value != 6 && up_right.value != 6){
        return 4
    }

    if (bottom_left.value != 6 && bottom_right.value != 6 && up_right.value != 6){
        return 3
    }

    if (bottom_left.value != 6 && bottom_right.value != 6 && up_left.value != 6){
        return 2
    }

    if (bottom_left.value !=6 && up_left.value != 6 && bottom_right.value == 6 && up_right.value == 6){
        return 7
    }
    if (bottom_left.value ==6 && up_left.value == 6 && bottom_right.value != 6 && up_right.value != 6){
        return 8
    }
    if (bottom_left.value !=6 && up_left.value == 6 && bottom_right.value != 6 && up_right.value == 6){
        return 9
    }
    if (bottom_left.value ==6 && up_left.value != 6 && bottom_right.value == 6 && up_right.value != 6){
        return 10
    }

    if (bottom_left.value != 6){
        return 0
    }
    if (up_right.value != 6){
        return 0
    }
    if (bottom_right.value != 6){
        return 1
    }
    if (up_left.value != 6){
        return 1
    }

    return 0
}

function create_river(){
    for(var i = 0; i<width;i++){
        ds_grid_set(grid, i, 0, {value:6, _id:noone})
        ds_grid_set(grid, i, height-1, {value:6, _id:noone})

        for(var j = power(abs((width/2)-i),2)/(width/2) + spacing + choose(0,-1); j >= 0; j--){
            ds_grid_set(grid, i, j, {value:6, _id:noone})
        }
        for(var j = power(abs((width/2)-i),2)/(width/2) + spacing + choose(0,-1); j >= 0; j--){
            ds_grid_set(grid, i, width-j-1, {value:6, _id:noone})
        }
    }
    for(var i = 0; i<height;i++){
        ds_grid_set(grid, 0, i, {value:6, _id:noone})
        ds_grid_set(grid, width-1, i, {value:6, _id:noone})
        for(var j = power(abs((height/2)-i),2)/(height/2) + spacing + choose(0,-1); j >= 0; j--){
            ds_grid_set(grid, j, i, {value:6, _id:noone})
        }
        for(var j = power(abs((height/2)-i),2)/(height/2) + spacing + choose(0,-1); j >= 0; j--){
            ds_grid_set(grid, height-j-1, i, {value:6, _id:noone})
        }
    }
    var side = choose(0,1)
    if side = 0{
        var startX = round(random_range(13,width-13))
        var startY = round(random_range(9,height-9))
        var offsetX = 0
        for(var i = 0; i<width;i++){
            ds_grid_set(grid, startX+offsetX, i, {value:6, _id:noone})
            ds_grid_set(grid, startX+1+offsetX, i, {value:6, _id:noone})
            ds_grid_set(grid, startX-1+offsetX, i, {value:6, _id:noone})
            offsetX += choose(-1,-1,0,0,1,1)
        }
        var offsetY = 0
        for(var i = 0; i<height;i++){
            ds_grid_set(grid, i, startY+offsetY, {value:6, _id:noone})
            ds_grid_set(grid, i, startY+1+offsetY, {value:6, _id:noone})
            offsetY += choose(-1,-1,0,0,1,1)
        }
    } else {
        var startX = round(random_range(9,width-9))
        var startY = round(random_range(13,height-13))
        var offsetX = 0
        for(var i = 0; i<width;i++){
            ds_grid_set(grid, startX+offsetX, i, {value:6, _id:noone})
            ds_grid_set(grid, startX+1+offsetX, i, {value:6, _id:noone})
            offsetX += choose(-1,-1,0,0,1,1)
        }
        var offsetY = 0
        for(var i = 0; i<height;i++){
            ds_grid_set(grid, i, startY+offsetY, {value:6, _id:noone})
            ds_grid_set(grid, i, startY+1+offsetY, {value:6, _id:noone})
            ds_grid_set(grid, i, startY-1+offsetY, {value:6, _id:noone})
            offsetY += choose(-1,-1,0,0,1,1)
        }
    }
}

create_river()
