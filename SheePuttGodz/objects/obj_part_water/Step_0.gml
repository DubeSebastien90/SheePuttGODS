
image_angle += angle_speed*angle_side

x += dcos(spd)
y -= dsin(spd)

life -= 1
if life < 0{
	image_alpha = lerp(image_alpha,0,0.1)
	if image_alpha < 0.1{
		instance_destroy()
	}
}