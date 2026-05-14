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
stun_time = 0;
stun_timer = 60*8;

rot = 0;
tempsRot = 0;

state = "searching";
target_sheep = noone;

aggro_range = 10;
atck_range = 0.7;
path_jitter = 8;
approach_radius = 0.7;

mp_grid = obj_grid.level.mp_grid;

wolf_side = 1
wolf_xscale = 1.0
wolf_rot = 0
wolf_rot_time = 0
wolf_moving = false

isStomped = false

function stunWolf(){
	image_index = 2
	depth = 200
	isStomped = true
}
