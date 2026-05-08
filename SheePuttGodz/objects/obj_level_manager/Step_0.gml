if debug_mode {
    if (keyboard_check_pressed(ord("R"))) load_level(current_level_index);
    if (keyboard_check_pressed(ord("N"))) load_level(++current_level_index);
}