var current_tile = get_selected_tile(mouse_x, mouse_y);

if (0 <= current_tile.x && current_tile.x < width && 0 <= current_tile.y && current_tile.y < height) {
    tile_selected = current_tile;
} else {
    tile_selected = {x: -1, y: -1};
}

// Cycle levels
if keyboard_check_pressed(vk_right) {
    current_level = (current_level + 1) mod array_length(level_data);
    load_level(current_level);
}
if keyboard_check_pressed(vk_left) {
    current_level = (current_level - 1 + array_length(level_data)) mod array_length(level_data);
    load_level(current_level);
}

if keyboard_check_pressed(vk_tab) {
    window_set_fullscreen(!window_get_fullscreen());
}
