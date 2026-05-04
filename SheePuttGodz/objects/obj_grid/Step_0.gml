var current_tile = get_selected_tile(mouse_x, mouse_y)

if (0 <= current_tile.x && current_tile.x < width && 0 <= current_tile.y && current_tile.y < height) {
    tile_selected = current_tile
} else {
    tile_selected = {x: -1, y: -1}
}

if keyboard_check_pressed(vk_tab){
    window_set_fullscreen(!window_get_fullscreen())
}
