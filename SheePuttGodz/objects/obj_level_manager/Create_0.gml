current_level_index = 0;
level_data = undefined;

function load_level(_index) {
    current_level_index  = _index;
    level_data = get_level_data(_index);
    global.current_level = level_data;

    var tw = sprite_get_width(spr_tiles)  / 2;
    var th = sprite_get_height(spr_tiles) / 4;
    grid_init(
        room_width  / 2,
        (room_height / 2) - (level_data.height * th),
        tw, th
    );

    if (!instance_exists(obj_map_renderer)) {
        instance_create_depth(0, 0, 0, obj_map_renderer);
    }

    with (obj_map_renderer) {
        build_mesh(other.level_data);
    }
}

load_level(current_level_index);