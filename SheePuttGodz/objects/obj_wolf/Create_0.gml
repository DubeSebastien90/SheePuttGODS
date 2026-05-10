grid_x = 0;
grid_y = 0;

image_speed = 0;
walkspd = 0.015;

my_path = path_add();
current_node = 1;

path_time = 0;
path_timer = 60;
eat_time = 0;
eat_timer = 60;

state = "searching";
target_sheep = noone;

aggro_range = 10;

mp_grid = obj_grid.level.mp_grid;