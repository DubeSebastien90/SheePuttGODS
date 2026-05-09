vel_z += gravity;
world_z += vel_z;

if (world_z <= 0) {
    world_z = 0;
    vel_z = 0;
}