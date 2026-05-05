var current_tile = get_selected_tile(mouse_x, mouse_y);

if (0 <= current_tile.x && current_tile.x < grid.width && 0 <= current_tile.y && current_tile.y < grid.height) {
    tile_selected = current_tile;
} else {
    tile_selected = {x: -1, y: -1};
}

// Cycle levels
if keyboard_check_pressed(vk_right) {
    current_level = (current_level + 1) mod array_length(levels);
    grid = levels[current_level];
}
if keyboard_check_pressed(vk_left) {
    current_level = (current_level - 1 + array_length(levels)) mod array_length(levels);
    grid = levels[current_level];
}

if keyboard_check_pressed(vk_tab) {
    window_set_fullscreen(!window_get_fullscreen());
}
