current_level_index = 0;

function load_level(_index) {
    current_level_index  = _index;
    global.current_level = get_level_data(_index);

    with (obj_renderer) {
        build_mesh();
    }
}

load_level(current_level_index);